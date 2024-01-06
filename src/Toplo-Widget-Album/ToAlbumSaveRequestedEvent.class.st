Class {
	#name : #ToAlbumSaveRequestedEvent,
	#superclass : #ToAlbumClientEvent,
	#instVars : [
		'unacceptedEdits',
		'accepted'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #accessing }
ToAlbumSaveRequestedEvent >> accepted [

	^ accepted ifNil: [ accepted := false ]
]

{ #category : #accessing }
ToAlbumSaveRequestedEvent >> accepted: aBoolean [

	accepted := aBoolean
]

{ #category : #copying }
ToAlbumSaveRequestedEvent >> copySharedStatesFrom: anEvent [

	super copySharedStatesFrom: anEvent.
	self accepted: anEvent accepted.
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
