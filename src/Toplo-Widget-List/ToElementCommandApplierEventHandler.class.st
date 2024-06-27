Class {
	#name : #ToElementCommandApplierEventHandler,
	#superclass : #ToCommandApplierEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'element',
		'commandQueue',
		'applicationTask',
		'queued'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToElementCommandApplierEventHandler >> element: anElement [

	element := anElement
]

{ #category : #'event handling' }
ToElementCommandApplierEventHandler >> elementCommandAddedEvent: aCommandAddedEvent [

	"element isAttachedToSceneGraph ifFalse: [
		aCommandAddedEvent currentTarget dispatchApplicationRequestOfCommand: aCommandAddedEvent command.
		^ self ]."

	commandQueue add: aCommandAddedEvent command.
	aCommandAddedEvent currentTarget dispatchEvent:
		ToCommandApplicationTaskActivationEvent new.
	element spaceDo: [ :sp | sp requestNextPulse ]
]

{ #category : #'event handling' }
ToElementCommandApplierEventHandler >> elementCommandApplicationRequest: anEvent [

	anEvent currentTarget applyCommand: anEvent command
]

{ #category : #'event handling' }
ToElementCommandApplierEventHandler >> elementCommandApplicationTaskActivationEvent: aCommandsApplicationRequestEvent [

	self postApplicationTask
]

{ #category : #'api - accessing' }
ToElementCommandApplierEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  ToElementCommandApplicationRequest.
		  ToCommandApplicationTaskActivationEvent }
]

{ #category : #'api - hooks' }
ToElementCommandApplierEventHandler >> onInstalledIn: aSelecter [

	super onInstalledIn: aSelecter.

	commandQueue := OrderedCollection new.
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
ToElementCommandApplierEventHandler >> onUninstalledIn: aSelecter [

	super onUninstalledIn: aSelecter.

	commandQueue := nil.
	applicationTask := nil.
]

{ #category : #'event handling' }
ToElementCommandApplierEventHandler >> postApplicationTask [
	"Post children update runnable to consume update operations"
	queued ifTrue: [ ^ self ].
	queued := true.
	" Allow re-lauching of the same task"
	applicationTask setNew.
	" enqueue the update task "
	element enqueueTask: applicationTask
]
