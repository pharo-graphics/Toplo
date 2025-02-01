Class {
	#name : #ToCommandApplicationTask,
	#superclass : #BlTask,
	#instVars : [
		'commandQueue',
		'finishedAction',
		'posponedRequestTask',
		'element'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #'api - running' }
ToCommandApplicationTask >> applyAll [

	element ifNil: [ ^ self ].
	self canApplyCommands ifFalse: [
		posponedRequestTask ifNotNil: [ ^ self ].
		posponedRequestTask := BlTaskAction new.
		posponedRequestTask action: [ self privateApplyAll ].
		element enqueueTask: posponedRequestTask.
		^ self ].

	self privateApplyAll
]

{ #category : #'api - running' }
ToCommandApplicationTask >> canApplyCommands [
	
	^ element notNil and: [ element isAttachedToSceneGraph ]
]

{ #category : #initialization }
ToCommandApplicationTask >> commandQueue: aQueue [
	
	commandQueue := aQueue
]

{ #category : #accessing }
ToCommandApplicationTask >> element: anElement [

	element := anElement
]

{ #category : #accessing }
ToCommandApplicationTask >> finishedAction: aValuable [

	finishedAction := aValuable
]

{ #category : #'api - running' }
ToCommandApplicationTask >> privateApplyAll [

	| nextInQueue |
	[ commandQueue isEmpty ] whileFalse: [
		nextInQueue := commandQueue removeFirst.
		nextInQueue applier applyCommand: nextInQueue command]
]

{ #category : #'api - running' }
ToCommandApplicationTask >> run [

	self applyAll.
	finishedAction value.
]
