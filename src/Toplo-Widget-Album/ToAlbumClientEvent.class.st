Class {
	#name : #ToAlbumClientEvent,
	#superclass : #BlEvent,
	#instVars : [
		'client'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #accessing }
ToAlbumClientEvent >> client [

	^ client
]

{ #category : #accessing }
ToAlbumClientEvent >> client: anObject [

	client := anObject
]
