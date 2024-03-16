Class {
	#name : #ToAlbumAfterTextInsertedOrDeletedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #accessing }
ToAlbumAfterTextInsertedOrDeletedEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToAlbumAfterTextInsertedOrDeletedEvent >> sourceEvent: anObject [

	sourceEvent := anObject
]
