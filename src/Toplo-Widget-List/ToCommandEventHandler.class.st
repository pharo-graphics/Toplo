Class {
	#name : #ToCommandEventHandler,
	#superclass : #BlCustomEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'commandQueue',
		'applicationTask'
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
		                   yourself.

	commandQueue nextPut: targetedCommand.
	applicationTask ifNotNil: [ ^ self ].
	applicationTask := BlTaskAction new action: [
		                   self applyAllIn: aTarget ].

	aTarget enqueueTask: applicationTask
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

]
