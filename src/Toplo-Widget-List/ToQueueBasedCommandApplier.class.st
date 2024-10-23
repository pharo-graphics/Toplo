Class {
	#name : #ToQueueBasedCommandApplier,
	#superclass : #ToCommandApplier,
	#instVars : [
		'commandQueue',
		'applicationTask',
		'queued',
		'weak'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #'event handling' }
ToQueueBasedCommandApplier >> command: aCommand addedIn: aSelecter [

	weak ifTrue: [
		element isAttachedToSceneGraph ifFalse: [
			aSelecter applyCommand: aCommand.
			^ self ] ].

	commandQueue nextPut: aCommand.
	self postApplicationTask.
	element spaceDo: [ :sp | sp requestNextPulse ]
]

{ #category : #initialization }
ToQueueBasedCommandApplier >> initialize [ 

	super initialize.
	weak := true
]

{ #category : #'api - hooks' }
ToQueueBasedCommandApplier >> onInstalledIn: aSelecter [

	super onInstalledIn: aSelecter.
	commandQueue := ToCommandQueue new.
	applicationTask := ToCommandApplicationTask new
		                   selecter: aSelecter;
		                   commandQueue: commandQueue;
		                   finishedAction: [ queued := false ];
		                   yourself.
	queued := false
]

{ #category : #'api - hooks' }
ToQueueBasedCommandApplier >> onUninstalledIn: aSelecter [

	super onUninstalledIn: aSelecter.
	commandQueue := nil.
	applicationTask := nil.
]

{ #category : #'event handling' }
ToQueueBasedCommandApplier >> postApplicationTask [
	"Post children update runnable to consume update operations"
	queued ifTrue: [ ^ self ].
	queued := true.
	" Allow re-lauching of the same task"
	applicationTask setNew.
	" enqueue the update task "
	element enqueueTask: applicationTask
]

{ #category : #accessing }
ToQueueBasedCommandApplier >> weak: aBoolean [

	weak := aBoolean
]
