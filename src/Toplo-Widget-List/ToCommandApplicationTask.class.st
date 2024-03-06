Class {
	#name : #ToCommandApplicationTask,
	#superclass : #BlTask,
	#instVars : [
		'commandQueue',
		'finishedAction'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'api - running' }
ToCommandApplicationTask >> applyAll [

	| nextInQueue |
	[ (nextInQueue := commandQueue nextOrNil) isNotNil ] whileTrue: [
		nextInQueue apply ]
]

{ #category : #initialization }
ToCommandApplicationTask >> commandQueue: aWaitFreeQueue [
	
	commandQueue := aWaitFreeQueue
]

{ #category : #accessing }
ToCommandApplicationTask >> finishedAction: aValuable [

	finishedAction := aValuable
]

{ #category : #'api - running' }
ToCommandApplicationTask >> run [

	"I perform all the commands stored in the queue "
	self applyAll.
	finishedAction value
]
