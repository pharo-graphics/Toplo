Class {
	#name : #ToSelectFilterTextFieldEventHandler,
	#superclass : #ToAlbumEventHandler,
	#category : #'Toplo-Widget-Select'
}

{ #category : #'api - accessing' }
ToSelectFilterTextFieldEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { AlbTextEditedEvent. AlbTextReplacedEvent }
]

{ #category : #'event handling' }
ToSelectFilterTextFieldEventHandler >> textEditedEvent: anEvent [

	anEvent currentTarget selectElement filterStringChanged
]

{ #category : #'event handling' }
ToSelectFilterTextFieldEventHandler >> textReplacedEvent: anEvent [

	anEvent currentTarget selectElement filterStringChanged
]
