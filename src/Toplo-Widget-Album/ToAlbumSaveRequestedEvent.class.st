Class {
	#name : #ToAlbumSaveRequestedEvent,
	#superclass : #ToAlbumClientEvent,
	#instVars : [
		'unacceptedEdits',
		'validated'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #copying }
ToAlbumSaveRequestedEvent >> copySharedStatesFrom: anEvent [

	super copySharedStatesFrom: anEvent.
	self validated: anEvent validated.
	self unacceptedEdits: anEvent unacceptedEdits.
]

{ #category : #accessing }
ToAlbumSaveRequestedEvent >> unacceptedEdits [

	^ unacceptedEdits
]

{ #category : #accessing }
ToAlbumSaveRequestedEvent >> unacceptedEdits: aBoolean [

	unacceptedEdits := aBoolean
]

{ #category : #accessing }
ToAlbumSaveRequestedEvent >> validated [

	^ validated ifNil: [ validated := false ]
]

{ #category : #accessing }
ToAlbumSaveRequestedEvent >> validated: aBoolean [

	validated := aBoolean
]
