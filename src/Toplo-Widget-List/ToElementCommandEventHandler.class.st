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

	| element |

	element := aCommandAddedEvent currentTarget.
	element isAttachedToSceneGraph ifFalse: [
		aCommandAddedEvent command notifyIn: element.
		^ self ].
	commandQueue add: aCommandAddedEvent command.
	element dispatchEvent: ToElementCommandApplicationTaskActivationEvent new.
	element spaceDo: [ :sp | sp requestNextPulse ] 
]

{ #category : #'event handling' }
ToElementCommandEventHandler >> elementCommandApplicationTaskActivationEvent: aCommandsApplicationRequestEvent [

	self postApplicationTaskIn: aCommandsApplicationRequestEvent currentTarget
]

{ #category : #'api - accessing' }
ToElementCommandEventHandler >> eventsToHandle [

	^ super eventsToHandle
	  , { ToElementCommandApplicationTaskActivationEvent }
]

{ #category : #'api - hooks' }
ToElementCommandEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.

	commandQueue := OrderedCollection new.
	applicationTask := ToElementCommandApplicationTask new
		                   commandQueue: commandQueue;
		                   element: anElement;
		                   finishedAction: [ queued := false ];
		                   yourself.
	queued := false
]

{ #category : #'api - hooks' }
ToElementCommandEventHandler >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

	commandQueue := nil.
	applicationTask := nil.
]

{ #category : #'event handling' }
ToElementCommandEventHandler >> postApplicationTaskIn: anElement [
	"Post children update runnable to consume update operations"
	
	queued ifTrue: [ ^ self ].
	queued := true.
	" Allow re-lauching of the same task"
	applicationTask setNew.
	" enqueue the update task "
	anElement enqueueTask: applicationTask
]
