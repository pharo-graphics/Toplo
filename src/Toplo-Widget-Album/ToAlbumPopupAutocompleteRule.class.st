Class {
	#name : #ToAlbumPopupAutocompleteRule,
	#superclass : #ToAlbumAutocompleteRule,
	#instVars : [
		'windowManager'
	],
	#category : #'Toplo-Widget-Album-Autocompletion'
}

{ #category : #accessing }
ToAlbumPopupAutocompleteRule >> choices: aListOfChoices [

	aListOfChoices
		ifEmpty: [ self closeChoicesPopup ]
		ifNotEmpty: [ self openChoicesPopupWith: aListOfChoices ]
]

{ #category : #'api - hooks' }
ToAlbumPopupAutocompleteRule >> onInstalledIn: anAlbum [

	windowManager := ToAnchoredWindowManager new builder: [
		                 :anchWin
		                 :request |  ].
	windowManager onInstalledIn: anAlbum
]

{ #category : #'api - hooks' }
ToAlbumPopupAutocompleteRule >> onUninstalledIn: anAlbum [

	windowManager onUninstalledIn: anAlbum.
	windowManager := nil
]
