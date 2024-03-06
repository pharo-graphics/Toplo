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

	commandQueue nextPut: targetedCommand.
	self postApplicationTaskIn: aTarget
]

{ #category : #'event handling' }
ToCommandEventHandler >> applyAllIn: aTarget [

	| nextInQueue |
	applicationTask := nil.
	[ (nextInQueue := commandQueue nextOrNil) isNotNil ] whileTrue: [
		nextInQueue applyIn: aTarget ]
]

{ #category : #'event handling' }
ToCommandEventHandler >> commandAddedEvent: aCommandAddedEvent [

	self
		addComand: aCommandAddedEvent command
		fromOperator: aCommandAddedEvent operator
		inTarget: aCommandAddedEvent currentTarget
]

{ #category : #'api - accessing' }
ToCommandEventHandler >> eventsToHandle [

	^ { ToCommandAddedEvent }
]

{ #category : #initialization }
ToCommandEventHandler >> initialize [

	super initialize.
	commandQueue := WaitfreeQueue new.
	applicationTask := ToCommandApplicationTask new
		                   commandQueue: commandQueue;
		                   finishedAction: [ queued := false ];
		                   yourself.
	queued := false
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
