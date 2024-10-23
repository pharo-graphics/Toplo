Class {
	#name : #ToCommandApplicationTask,
	#superclass : #BlTask,
	#instVars : [
		'commandQueue',
		'finishedAction',
		'posponedRequestTask',
		'selecter'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #'api - running' }
ToCommandApplicationTask >> applyAll [

	self element ifNil: [ ^ self ].
	self canApplyCommands ifFalse: [
		posponedRequestTask ifNotNil: [ ^ self ].
		posponedRequestTask := BlTaskAction new.
		posponedRequestTask action: [ self privateApplyAll ].
		self element enqueueTask: posponedRequestTask.
		^ self ].

	self privateApplyAll
]

{ #category : #'api - running' }
ToCommandApplicationTask >> canApplyCommands [
	
	^ self element notNil and: [ self element isAttachedToSceneGraph ]
]

{ #category : #initialization }
ToCommandApplicationTask >> commandQueue: aQueue [
	
	commandQueue := aQueue
]

{ #category : #accessing }
ToCommandApplicationTask >> element [

	^ selecter element
]

{ #category : #accessing }
ToCommandApplicationTask >> finishedAction: aValuable [

	finishedAction := aValuable
]

{ #category : #'api - running' }
ToCommandApplicationTask >> privateApplyAll [

	| nextInQueue |
	[ (nextInQueue := commandQueue nextOrNil) isNotNil ] whileTrue: [
		selecter applyCommand: nextInQueue ]
]

{ #category : #'api - running' }
ToCommandApplicationTask >> run [

	self applyAll.
	finishedAction value.
]

{ #category : #accessing }
ToCommandApplicationTask >> selecter: aSelecter [

	selecter := aSelecter
]
