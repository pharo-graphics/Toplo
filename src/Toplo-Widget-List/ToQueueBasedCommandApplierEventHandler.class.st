Class {
	#name : #ToQueueBasedCommandApplierEventHandler,
	#superclass : #ToCommandApplierEventHandler,
	#instVars : [
		'element',
		'commandQueue',
		'applicationTask',
		'queued',
		'weak'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToQueueBasedCommandApplierEventHandler >> element: anElement [

	element := anElement
]

{ #category : #'event handling' }
ToQueueBasedCommandApplierEventHandler >> elementCommandAddedEvent: aCommandAddedEvent [

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
ToQueueBasedCommandApplierEventHandler >> elementCommandApplicationRequest: anEvent [

	anEvent currentTarget applyCommand: anEvent command
]

{ #category : #'event handling' }
ToQueueBasedCommandApplierEventHandler >> elementCommandApplicationTaskActivationEvent: aCommandsApplicationRequestEvent [

	self postApplicationTask
]

{ #category : #'api - accessing' }
ToQueueBasedCommandApplierEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  ToElementCommandApplicationRequest.
		  ToCommandApplicationTaskActivationEvent }
]

{ #category : #initialization }
ToQueueBasedCommandApplierEventHandler >> initialize [ 

	super initialize.
	weak := true
]

{ #category : #'api - hooks' }
ToQueueBasedCommandApplierEventHandler >> onInstalledIn: aSelecter [

	super onInstalledIn: aSelecter.

	commandQueue := WaitfreeQueue new.
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
ToQueueBasedCommandApplierEventHandler >> onUninstalledIn: aSelecter [

	super onUninstalledIn: aSelecter.

	commandQueue := nil.
	applicationTask := nil.
]

{ #category : #'event handling' }
ToQueueBasedCommandApplierEventHandler >> postApplicationTask [
	"Post children update runnable to consume update operations"
	queued ifTrue: [ ^ self ].
	queued := true.
	" Allow re-lauching of the same task"
	applicationTask setNew.
	" enqueue the update task "
	element enqueueTask: applicationTask
]

{ #category : #accessing }
ToQueueBasedCommandApplierEventHandler >> weak: aBoolean [

	weak := aBoolean
]
