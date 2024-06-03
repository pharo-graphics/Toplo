Class {
	#name : #ToCommandOperator,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
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

{ #category : #'event management accessing' }
ToCommandOperator >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #initialization }
ToCommandOperator >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self
]
