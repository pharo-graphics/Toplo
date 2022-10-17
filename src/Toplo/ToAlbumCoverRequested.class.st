Class {
	#name : #ToAlbumCoverRequested,
	#superclass : #AlbViewModelAnnouncement,
	#instVars : [
		'message',
		'background'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #accessing }
ToAlbumCoverRequested >> background [

	^ background
]

{ #category : #accessing }
ToAlbumCoverRequested >> background: aBlBackground [

	background := aBlBackground
]
