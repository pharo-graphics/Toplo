Class {
	#name : #ToCommandOperator,
	#superclass : #Object,
	#traits : 'TBlEventTarget + TToPrenotificationTarget',
	#classTraits : 'TBlEventTarget classTrait + TToPrenotificationTarget classTrait',
	#instVars : [
		'eventDispatcher'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #accessing }
ToCommandOperator >> addCommand: aCommand [

	self dispatchEvent: (ToElementCommandAddedEvent new
			 operator: self;
			 command: aCommand yourself)
]

{ #category : #'command application' }
ToCommandOperator >> applyCommand: aCommand [ 
	
	aCommand applyOn: self
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
