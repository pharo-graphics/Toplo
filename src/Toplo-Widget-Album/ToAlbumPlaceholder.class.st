Class {
	#name : 'ToAlbumPlaceholder',
	#superclass : 'ToPlaceholderLayer',
	#category : 'Toplo-Widget-Album-TextPane',
	#package : 'Toplo-Widget-Album',
	#tag : 'TextPane'
}

{ #category : 'api - attaching / detaching' }
ToAlbumPlaceholder >> attachTo: anElement [

	super attachTo: anElement.
	self padding: anElement padding
]

{ #category : 'initialization' }
ToAlbumPlaceholder >> initialize [

	super initialize.
	self layout alignCenter
]
