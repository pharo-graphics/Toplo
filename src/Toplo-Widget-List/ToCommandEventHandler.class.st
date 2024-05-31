Class {
	#name : #ToCommandEventHandler,
	#superclass : #BlCustomEventHandler,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'element'
	],
	#category : #'Toplo-Widget-List-Command-support'
}

{ #category : #accessing }
ToCommandEventHandler >> element: anElement [

	element := anElement
]

{ #category : #'event handling' }
ToCommandEventHandler >> elementCommandAddedEvent: aCommandAddedEvent [

	self subclassResponsibility 
]

{ #category : #'event handling' }
ToCommandEventHandler >> elementCommandApplicationEvent: anEvent [

	anEvent currentTarget
		applyCommand: anEvent command
]

{ #category : #'api - accessing' }
ToCommandEventHandler >> eventsToHandle [

	^ { ToElementCommandAddedEvent. ToElementCommandApplicationEvent.}
]
