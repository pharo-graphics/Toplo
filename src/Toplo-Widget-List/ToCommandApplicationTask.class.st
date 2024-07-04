Class {
	#name : #ToCommandApplicationTask,
	#superclass : #BlTask,
	#instVars : [
		'applier',
		'commandQueue',
		'finishedAction',
		'element',
		'operator',
		'posponedRequestTask'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToCommandApplicationTask >> applier: anObject [

	applier := anObject
]

{ #category : #'api - running' }
ToCommandApplicationTask >> applyAll [

	| nextInQueue |
	
	self canApplyCommands ifFalse: [
		finishedAction value.
		posponedRequestTask ifNotNil: [ ^ self ].
		posponedRequestTask := BlTaskAction new.
		posponedRequestTask action: [
			applier dispatchEvent: ToCommandApplicationTaskActivationEvent new ].
		element enqueueTask: posponedRequestTask.
		^ self ].

	[ (nextInQueue := commandQueue nextOrNil) isNotNil ] whileTrue: [
		applier applyCommand: nextInQueue ]
]

{ #category : #'api - running' }
ToCommandApplicationTask >> canApplyCommands [

	^ element isAttachedToSceneGraph
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

{ #category : #accessing }
ToCommandApplicationTask >> operator: anOperator [

	operator := anOperator
]

{ #category : #'api - running' }
ToCommandApplicationTask >> run [

	self applyAll.
	finishedAction value
]
