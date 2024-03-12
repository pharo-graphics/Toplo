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
ToCommandEventHandler >> commandAddedEvent: aCommandAddedEvent [

	| listElement |
	listElement := aCommandAddedEvent currentTarget.
	listElement isAttachedToSceneGraph ifFalse: [
		aCommandAddedEvent command applyIn: listElement.
		^ self ].
	commandQueue add: aCommandAddedEvent command.
	listElement dispatchEvent: ToCommandsApplicationRequestEvent new
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
