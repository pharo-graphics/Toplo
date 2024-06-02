Class {
	#name : #ToCommandOperator,
	#superclass : #Object,
	#traits : 'TBlEventTarget + TToPrenotificationTarget',
	#classTraits : 'TBlEventTarget classTrait + TToPrenotificationTarget classTrait',
	#instVars : [
		'commandApplicationManager',
		'eventDispatcher'
	],
	#category : #'Toplo-Widget-List-Command-Operator'
}

{ #category : #accessing }
ToCommandOperator >> addCommand: aCommand [

	self dispatchEvent: (ToElementCommandAddedEvent new
			 command: aCommand yourself)
]

{ #category : #'command application' }
ToCommandOperator >> applyCommand: aCommand [

	commandApplicationManager applyCommand: aCommand withOperator: self
]

{ #category : #accessing }
ToCommandOperator >> commandApplicationManager: aCommandApplicationManager [

	commandApplicationManager := aCommandApplicationManager 
]

{ #category : #initialization }
ToCommandOperator >> commandApplicationManagerClass [

	^ ToCommandApplicationManager
]

{ #category : #'event management accessing' }
ToCommandOperator >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #initialization }
ToCommandOperator >> initialize [ 

	super initialize.
	commandApplicationManager := self newCommandApplicationManager.
	eventDispatcher := BlDirectEventDispatcher on: self
]

{ #category : #initialization }
ToCommandOperator >> newCommandApplicationManager [

	^ self commandApplicationManagerClass new
]
