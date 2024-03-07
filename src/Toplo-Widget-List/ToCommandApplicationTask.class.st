Class {
	#name : #ToCommandApplicationTask,
	#superclass : #BlTask,
	#instVars : [
		'commandQueue',
		'finishedAction',
		'listElement'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'api - running' }
ToCommandApplicationTask >> applyAll [

	listElement critical: [
		[ commandQueue isEmpty ] whileFalse: [
			| nextInQueue |
			nextInQueue := commandQueue removeFirst.
			nextInQueue apply ] ]
]

{ #category : #'api - running' }
ToCommandApplicationTask >> canApplyCommands [

	| infiniteElement |
	listElement space isApplyingSkinInstallers ifTrue: [ ^ false ].
	infiniteElement := listElement infinite.
	infiniteElement isFirstLayoutComplete ifFalse: [ ^ false ].
	infiniteElement isAttached ifFalse: [ ^ false ].
	infiniteElement isLayoutFrozen ifTrue: [ ^ false ].

	^ true
]

{ #category : #initialization }
ToCommandApplicationTask >> commandQueue: aWaitFreeQueue [
	
	commandQueue := aWaitFreeQueue
]

{ #category : #accessing }
ToCommandApplicationTask >> finishedAction: aValuable [

	finishedAction := aValuable
]

{ #category : #accessing }
ToCommandApplicationTask >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #'api - running' }
ToCommandApplicationTask >> run [

	self canApplyCommands ifFalse: [
		finishedAction value.
		listElement enqueueTask: (BlTaskAction new action: [
				 listElement dispatchEvent: ToCommandsApplicationRequestEvent new ]).
		^ self ].

	self applyAll.
	finishedAction value
]
