Class {
	#name : #ToElementCommandManagerEventHandler,
	#superclass : #ToCommandManagerEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'element',
		'commandQueue',
		'applicationTask',
		'queued'
	],
	#category : #'Toplo-Widget-List-Command-Support-not-used'
}

{ #category : #accessing }
ToElementCommandManagerEventHandler >> element: anElement [

	element := anElement
]

{ #category : #'event handling' }
ToElementCommandManagerEventHandler >> elementCommandAddedEvent: aCommandAddedEvent [

	element isAttachedToSceneGraph ifFalse: [
		aCommandAddedEvent currentTarget dispatchApplicationRequestOfCommand: aCommandAddedEvent command.
		^ self ].

	commandQueue add: aCommandAddedEvent command.
	aCommandAddedEvent currentTarget dispatchEvent:
		ToCommandApplicationTaskActivationEvent new.
	element spaceDo: [ :sp | sp requestNextPulse ]
]

{ #category : #'event handling' }
ToElementCommandManagerEventHandler >> elementCommandApplicationRequest: anEvent [

	anEvent currentTarget applyCommand: anEvent command
]

{ #category : #'event handling' }
ToElementCommandManagerEventHandler >> elementCommandApplicationTaskActivationEvent: aCommandsApplicationRequestEvent [

	self postApplicationTask
]

{ #category : #'api - accessing' }
ToElementCommandManagerEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  ToElementCommandApplicationRequest.
		  ToCommandApplicationTaskActivationEvent }
]

{ #category : #'api - hooks' }
ToElementCommandManagerEventHandler >> onInstalledIn: anOperator [

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
ToElementCommandManagerEventHandler >> onUninstalledIn: anOperator [

	super onUninstalledIn: anOperator.

	commandQueue := nil.
	applicationTask := nil.
]

{ #category : #'event handling' }
ToElementCommandManagerEventHandler >> postApplicationTask [
	"Post children update runnable to consume update operations"
	queued ifTrue: [ ^ self ].
	queued := true.
	" Allow re-lauching of the same task"
	applicationTask setNew.
	" enqueue the update task "
	element enqueueTask: applicationTask
]
