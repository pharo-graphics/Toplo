Class {
	#name : #ToMenuWindowEventHandler,
	#superclass : #ToElementWithPopupEventHandler,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToMenuWindowEventHandler >> menuWindowClosedEvent: anEvent [

	self windowClosedEvent: anEvent
]

{ #category : #'event handling' }
ToMenuWindowEventHandler >> menuWindowOpenedEvent: anEvent [

	self windowOpenedEvent: anEvent
]
