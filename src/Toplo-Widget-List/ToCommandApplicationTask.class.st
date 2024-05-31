Class {
	#name : #ToCommandApplicationTask,
	#superclass : #BlTask,
	#instVars : [
		'commandQueue',
		'finishedAction',
		'element',
		'operator',
		'posponedRequestTask'
	],
	#category : #'Toplo-Widget-List-Command-support'
}

{ #category : #'api - running' }
ToCommandApplicationTask >> applyAll [

	[ commandQueue isEmpty ] whileFalse: [
		| nextInQueue |
		nextInQueue := commandQueue removeFirst.
		nextInQueue notifyAddedInOperator: operator ]
]

{ #category : #'api - running' }
ToCommandApplicationTask >> canApplyCommands [

	^ element isAttachedToSceneGraph
]

{ #category : #initialization }
ToCommandApplicationTask >> commandQueue: anOrderedCollection [
	
	commandQueue := anOrderedCollection
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

	self canApplyCommands ifFalse: [
		finishedAction value.
		posponedRequestTask ifNotNil: [ ^ self ].
		posponedRequestTask := BlTaskAction new.
		posponedRequestTask action: [
			operator dispatchEvent:
				ToCommandApplicationTaskActivationEvent new ].
		element enqueueTask: posponedRequestTask.
		^ self ].

	self applyAll.
	finishedAction value
]
