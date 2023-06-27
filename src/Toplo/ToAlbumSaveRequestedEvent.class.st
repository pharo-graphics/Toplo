Class {
	#name : #ToAlbumSaveRequestedEvent,
	#superclass : #ToAlbumClientEvent,
	#instVars : [
		'unacceptedEdits'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #accessing }
ToAlbumSaveRequestedEvent >> unacceptedEdits [

	^ unacceptedEdits
]

{ #category : #accessing }
ToAlbumSaveRequestedEvent >> unacceptedEdits: aBoolean [

	unacceptedEdits := aBoolean
]
