Class {
	#name : #ToElementCommandEventHandler,
	#superclass : #ToCommandEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'commandQueue',
		'applicationTask',
		'queued'
	],
	#category : #'Toplo-Widget-List-Command-support'
}

{ #category : #'event handling' }
ToElementCommandEventHandler >> elementCommandAddedEvent: aCommandAddedEvent [

	element isAttachedToSceneGraph ifFalse: [
		aCommandAddedEvent command notifyAddedInOperator:
			aCommandAddedEvent currentTarget.
		^ self ].

	commandQueue add: aCommandAddedEvent command.
	aCommandAddedEvent currentTarget dispatchEvent:
		ToCommandApplicationTaskActivationEvent new.
	element spaceDo: [ :sp | sp requestNextPulse ]
]

{ #category : #'event handling' }
ToElementCommandEventHandler >> elementCommandApplicationTaskActivationEvent: aCommandsApplicationRequestEvent [

	self postApplicationTask
]

{ #category : #'api - accessing' }
ToElementCommandEventHandler >> eventsToHandle [

	^ super eventsToHandle
	  , { ToCommandApplicationTaskActivationEvent }
]

{ #category : #'api - hooks' }
ToElementCommandEventHandler >> onInstalledIn: anOperator [

	super onInstalledIn: anOperator.

	commandQueue := OrderedCollection new.
	applicationTask := ToCommandApplicationTask new
		                   operator: anOperator;
		                   commandQueue: commandQueue;
		                   element: element;
		                   finishedAction: [ queued := false ];
		                   yourself.
	queued := false
]

{ #category : #'api - hooks' }
ToElementCommandEventHandler >> onUninstalledIn: anOperator [

	super onUninstalledIn: anOperator.

	commandQueue := nil.
	applicationTask := nil.
]

{ #category : #'event handling' }
ToElementCommandEventHandler >> postApplicationTask [
	"Post children update runnable to consume update operations"
	queued ifTrue: [ ^ self ].
	queued := true.
	" Allow re-lauching of the same task"
	applicationTask setNew.
	" enqueue the update task "
	element enqueueTask: applicationTask
]
