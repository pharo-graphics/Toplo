Class {
	#name : #ToInfiniteCommandApplicationTask,
	#superclass : #BlTask,
	#instVars : [
		'commandQueue',
		'finishedAction'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'api - running' }
ToInfiniteCommandApplicationTask >> applyAll [

	| nextInQueue |
	[ (nextInQueue := commandQueue nextOrNil) isNotNil ] whileTrue: [
		nextInQueue apply ]
]

{ #category : #initialization }
ToInfiniteCommandApplicationTask >> commandQueue: aWaitFreeQueue [
	
	commandQueue := aWaitFreeQueue
]

{ #category : #accessing }
ToInfiniteCommandApplicationTask >> finishedAction: aValuable [

	finishedAction := aValuable
]

{ #category : #'api - running' }
ToInfiniteCommandApplicationTask >> run [

	"actually perform all necessary updates and trigger layout update"
	self applyAll.
	finishedAction value
]
