Class {
	#name : #ToCommandEventHandler,
	#superclass : #BlCustomEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'commandQueue',
		'applicationTask',
		'queued'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'event handling' }
ToCommandEventHandler >> addComand: aCommand fromOperator: anOperator inTarget: aTarget [

	| targetedCommand |
	aTarget isAttachedToSceneGraph ifFalse: [
		anOperator applyCommand: aCommand in: aTarget.
		^ self ].

	targetedCommand := ToApplicableCommand new
		                   operator: anOperator;
		                   command: aCommand;
		                   target: aTarget;
		                   yourself.

	commandQueue add: targetedCommand.
	aTarget dispatchEvent: ToCommandsApplicationRequestEvent new
]

{ #category : #'event handling' }
ToCommandEventHandler >> commandAddedEvent: aCommandAddedEvent [

	self
		addComand: aCommandAddedEvent command
		fromOperator: aCommandAddedEvent operator
		inTarget: aCommandAddedEvent currentTarget
]

{ #category : #'event handling' }
ToCommandEventHandler >> commandsApplicationRequestEvent: aCommandsApplicationRequestEvent [

	self postApplicationTaskIn: aCommandsApplicationRequestEvent currentTarget
]

{ #category : #'api - accessing' }
ToCommandEventHandler >> eventsToHandle [

	^ { ToCommandAddedEvent. ToCommandsApplicationRequestEvent }
]

{ #category : #'api - hooks' }
ToCommandEventHandler >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.

	commandQueue := OrderedCollection new.
	applicationTask := ToCommandApplicationTask new
		                   commandQueue: commandQueue;
		                   listElement: aListElement;
		                   finishedAction: [ queued := false ];
		                   yourself.
	queued := false
]

{ #category : #'api - hooks' }
ToCommandEventHandler >> onUninstalledIn: aListElement [

	super onUninstalledIn: aListElement.

	commandQueue := nil.
	applicationTask := nil.
]

{ #category : #'event handling' }
ToCommandEventHandler >> postApplicationTaskIn: anEventTarget [
	"Post children update runnable to consume update operations"
	
	queued ifTrue: [ ^ self ].
	queued := true.
	" Allow re-lauching of the same task"
	applicationTask setNew.
	" enqueue the update task "
	anEventTarget enqueueTask: applicationTask
]
