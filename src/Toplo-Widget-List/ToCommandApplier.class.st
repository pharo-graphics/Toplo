Class {
	#name : #ToCommandApplier,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'element'
	],
	#category : #'Toplo-Widget-List-Command-Support'
}

{ #category : #accessing }
ToCommandApplier >> element: anElement [

	element := anElement
]

{ #category : #'event handling' }
ToCommandApplier >> elementCommandAddedEvent: aCommandAddedEvent [

	self subclassResponsibility 
]

{ #category : #'api - accessing' }
ToCommandApplier >> eventsToHandle [

	^ { ToElementCommandAddedEvent. }
]
