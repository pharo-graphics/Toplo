Class {
	#name : #ToElementCommandApplicationTask,
	#superclass : #BlTask,
	#instVars : [
		'commandQueue',
		'finishedAction',
		'element',
		'posponedRequestTask'
	],
	#category : #'Toplo-Widget-List-Command-support'
}

{ #category : #'api - running' }
ToElementCommandApplicationTask >> applyAll [

	[ commandQueue isEmpty ] whileFalse: [
		| nextInQueue |
		nextInQueue := commandQueue removeFirst.
		nextInQueue notifyIn: element ]
]

{ #category : #'api - running' }
ToElementCommandApplicationTask >> canApplyCommands [

	^ element isAttachedToSceneGraph
]

{ #category : #initialization }
ToElementCommandApplicationTask >> commandQueue: anOrderedCollection [
	
	commandQueue := anOrderedCollection
]

{ #category : #accessing }
ToElementCommandApplicationTask >> element: anElement [

	element := anElement
]

{ #category : #accessing }
ToElementCommandApplicationTask >> finishedAction: aValuable [

	finishedAction := aValuable
]

{ #category : #'api - running' }
ToElementCommandApplicationTask >> run [

	self canApplyCommands ifFalse: [
		finishedAction value.
		posponedRequestTask ifNotNil: [ ^ self ].
		posponedRequestTask := BlTaskAction new.
		posponedRequestTask action: [
			element dispatchEvent: ToElementCommandApplicationTaskActivationEvent new ].
		element enqueueTask: posponedRequestTask.
		^ self ].

	self applyAll.
	finishedAction value
]
