Class {
	#name : #ToAlbumClientAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'client'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #accessing }
ToAlbumClientAnnouncement >> client [

	^ client
]

{ #category : #accessing }
ToAlbumClientAnnouncement >> client: anObject [

	client := anObject
]
