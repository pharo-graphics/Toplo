Class {
	#name : #ToAlbumEditingFrontEvent,
	#superclass : #BlEvent,
	#instVars : [
		'editorElement'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #accessing }
ToAlbumEditingFrontEvent >> client [

	self
		deprecated: 'Use #editorElement instead'
		transformWith: '`@rcvr client' -> '`@rcvr editorElement'.
	^ self editorElement
]

{ #category : #accessing }
ToAlbumEditingFrontEvent >> client: anObject [

	self
		deprecated: 'Use #editorElement: instead'
		transformWith: '`@rcvr client: `@arg' -> '`@rcvr editorElement:`@arg'.
	self editorElement: anObject
]

{ #category : #accessing }
ToAlbumEditingFrontEvent >> editorElement [

	^ editorElement
]

{ #category : #accessing }
ToAlbumEditingFrontEvent >> editorElement: anEditorElement [

	editorElement := anEditorElement
]
