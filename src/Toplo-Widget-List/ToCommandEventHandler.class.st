Class {
	#name : #ToCommandEventHandler,
	#superclass : #BlCustomEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'applicationTask',
		'commandQueue'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'event handling' }
ToCommandEventHandler >> addComand: aCommand fromOperator: anOperator forTarget: aTarget [

	| targetedCommand |
	
	aTarget isAttachedToSceneGraph ifFalse: [
		anOperator applyCommand: aCommand for: aTarget.
		^ self ].
	
	targetedCommand := ToApplicableCommand new
		                   operator: anOperator;
		                   command: aCommand;
		                   yourself.

	commandQueue nextPut: targetedCommand.
	
	applicationTask ifNotNil: [ ^ self ].
	applicationTask := BlTaskAction new action: [
		                   applicationTask := nil.
		                   aTarget dispatchEvent: ToCommandApplicationRequestEvent new ].
	aTarget enqueueTask: applicationTask.
	"aTarget infinite dataSourceManager onOtherCommand: targetedCommand."
	"aTarget infinite postChildrenUpdater."
]

{ #category : #'event handling' }
ToCommandEventHandler >> commandAddedEvent: aCommandAddedEvent [

	self
		addComand: aCommandAddedEvent command
		fromOperator: aCommandAddedEvent operator
		forTarget: aCommandAddedEvent currentTarget
]

{ #category : #'event handling' }
ToCommandEventHandler >> commandApplicationRequestEvent: aCommandApplicationRequestEvent [

	| nextInQueue |
	applicationTask ifNotNil: [
		aCommandApplicationRequestEvent currentTarget dequeueTask: applicationTask.
		applicationTask := nil ].
	[ (nextInQueue := commandQueue nextOrNil) isNotNil ] whileTrue: [
		nextInQueue applyFor: aCommandApplicationRequestEvent currentTarget ]
]

{ #category : #'api - accessing' }
ToCommandEventHandler >> eventsToHandle [

	^ { ToCommandAddedEvent. ToCommandApplicationRequestEvent }
]

{ #category : #initialization }
ToCommandEventHandler >> initialize [ 

	super initialize.
	commandQueue := WaitfreeQueue new.
]
