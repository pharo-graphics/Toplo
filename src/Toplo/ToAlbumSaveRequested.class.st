Class {
	#name : #ToAlbumSaveRequested,
	#superclass : #ToAlbumClientAnnouncement,
	#instVars : [
		'unacceptedEdits'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #accessing }
ToAlbumSaveRequested >> unacceptedEdits [

	^ unacceptedEdits
]

{ #category : #accessing }
ToAlbumSaveRequested >> unacceptedEdits: aBoolean [

	unacceptedEdits := aBoolean
]
