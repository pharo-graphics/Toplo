Class {
	#name : #ToAlbumTextChanged,
	#superclass : #ToAlbumClientAnnouncement,
	#instVars : [
		'text'
	],
	#category : #'Toplo-Widget-Album-Announcements'
}

{ #category : #accessing }
ToAlbumTextChanged >> text [

	^ text
]

{ #category : #accessing }
ToAlbumTextChanged >> text: aBlText [

	text := aBlText
]
