Class {
	#name : #ToCommandOperator,
	#superclass : #Object,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventDispatcher',
		'sharedEventDistributor',
		'element'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #accessing }
ToCommandOperator >> addCommand: aCommand [

	self dispatchEvent: (ToElementCommandAddedEvent new
			 command: aCommand
			 yourself)
]

{ #category : #'command application' }
ToCommandOperator >> applyCommand: aCommand in: aTarget [ 
	
	aCommand applyOn: aCommand operator in: aTarget
]

{ #category : #'event management' }
ToCommandOperator >> dispatchEvent: anEvent [
	"I only call my event dispatcher, so the event can be only handled by my event handlers/filters"

	element dispatchEvent: anEvent
]

{ #category : #'command operations' }
ToCommandOperator >> listScrollCommand: aCommand in: aTarget [

]

{ #category : #'api - hooks' }
ToCommandOperator >> onInstalledIn: anElement [

	element := anElement 
]

{ #category : #'api - hooks' }
ToCommandOperator >> onUninstalledIn: anEventTarget [

	element := nil
]
