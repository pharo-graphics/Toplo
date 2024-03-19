Class {
	#name : #ToAlbumAutocompleteListElement,
	#superclass : #ToListElement,
	#instVars : [
		'currentPattern',
		'fontName',
		'fontSize'
	],
	#category : #'Toplo-Widget-Album-Autocompletion'
}

{ #category : #accessing }
ToAlbumAutocompleteListElement >> currentPattern [

	^ currentPattern ifNil: [ currentPattern := '' ]
]

{ #category : #accessing }
ToAlbumAutocompleteListElement >> currentPattern: aString [

	currentPattern := aString
]

{ #category : #accessing }
ToAlbumAutocompleteListElement >> fontName [

	^ fontName ifNil: [ fontName := 'Source Code Pro' ]
]

{ #category : #accessing }
ToAlbumAutocompleteListElement >> fontName: aFontName [

	fontName := aFontName
]

{ #category : #accessing }
ToAlbumAutocompleteListElement >> fontSize [

	^ fontSize ifNil: [ fontSize := 11 ]
]

{ #category : #accessing }
ToAlbumAutocompleteListElement >> fontSize: anInteger [

	fontSize := anInteger
]
