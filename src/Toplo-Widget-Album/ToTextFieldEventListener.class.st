Class {
	#name : #ToTextFieldEventListener,
	#superclass : #ToAlbumEventListener,
	#category : #'Toplo-Widget-Album-TextField'
}

{ #category : #'api - accessing' }
ToTextFieldEventListener >> eventsToHandle [

	^ super eventsToHandle , {
		  BlMouseDownEvent.
		  BlMouseUpEvent }
]

{ #category : #'mouse handlers' }
ToTextFieldEventListener >> mouseDownEvent: anEvent [

	anEvent currentTarget infinite dispatchEvent: anEvent
]

{ #category : #'mouse handlers' }
ToTextFieldEventListener >> mouseUpEvent: anEvent [

	anEvent currentTarget infinite dispatchEvent: anEvent
]
