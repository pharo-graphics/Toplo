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
ToQueueBasedCommandApplier >> elementCommandAddedEvent: aCommandAddedEvent [

	weak ifTrue: [
		element isAttachedToSceneGraph ifFalse: [
			aCommandAddedEvent currentTarget applyCommand:
				aCommandAddedEvent command.
			^ self ] ].

	commandQueue nextPut: aCommandAddedEvent command.
	self postApplicationTask.
	element spaceDo: [ :sp | sp requestNextPulse ]
]

{ #category : #'event handling' }
ToQueueBasedCommandApplier >> elementCommandApplicationRequest: anEvent [

	anEvent currentTarget applyCommand: anEvent command
]

{ #category : #'event handling' }
ToQueueBasedCommandApplier >> elementCommandApplicationTaskActivationEvent: aCommandsApplicationRequestEvent [

	self postApplicationTask
]

{ #category : #'api - accessing' }
ToQueueBasedCommandApplier >> eventsToHandle [

	^ super eventsToHandle , {
		  ToElementCommandApplicationRequest.
		  ToCommandApplicationTaskActivationEvent }
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
		                   operator: aSelecter operator;
		                   applier: aSelecter;
		                   commandQueue: commandQueue;
		                   element: element;
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
