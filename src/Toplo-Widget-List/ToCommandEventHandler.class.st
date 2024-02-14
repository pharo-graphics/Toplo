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
ToCommandEventHandler >> applyAllCommands [

	| nextInQueue |
	[ (nextInQueue := commandQueue nextOrNil) isNotNil ] whileTrue: [
		nextInQueue apply ]
]

{ #category : #'event handling' }
ToCommandEventHandler >> commandAddedEvent: aCommandAddedEvent [

	| target targetedCommand |
	target := aCommandAddedEvent target.
	target isAttachedToSceneGraph ifFalse: [
		aCommandAddedEvent commandOperator
			applyCommand: aCommandAddedEvent command
			for: target.
		^ self ].
	targetedCommand := ToTargetedCommand new
		                   operator: aCommandAddedEvent commandOperator;
		                   target: target;
		                   command: aCommandAddedEvent command;
		                   yourself.
	commandQueue nextPut: targetedCommand.
	applicationTask ifNotNil: [ ^ self ].
	applicationTask := BlTaskAction new action: [
		                   self applyAllCommands.
		                   applicationTask := nil ].
	target enqueueTask: applicationTask.
	target requestLayout
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
