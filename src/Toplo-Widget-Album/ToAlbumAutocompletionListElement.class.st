Class {
	#name : #ToAlbumAutocompletionListElement,
	#superclass : #ToListElement,
	#instVars : [
		'currentPattern',
		'fontName',
		'fontSize'
	],
	#category : #'Toplo-Widget-Album-Incubator-Autocompletion'
}

{ #category : #accessing }
ToAlbumAutocompletionListElement >> currentPattern [

	^ currentPattern ifNil: [ currentPattern := '' ]
]

{ #category : #accessing }
ToAlbumAutocompletionListElement >> currentPattern: aString [

	currentPattern := aString
]

{ #category : #accessing }
ToAlbumAutocompletionListElement >> fontName [

	^ fontName ifNil: [ fontName := 'Source Code Pro' ]
]

{ #category : #accessing }
ToAlbumAutocompletionListElement >> fontName: aFontName [

	fontName := aFontName
]

{ #category : #accessing }
ToAlbumAutocompletionListElement >> fontSize [

	^ fontSize ifNil: [ fontSize := 11 ]
]

{ #category : #accessing }
ToAlbumAutocompletionListElement >> fontSize: anInteger [

	fontSize := anInteger
]
