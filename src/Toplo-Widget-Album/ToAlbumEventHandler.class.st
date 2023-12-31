Class {
	#name : #ToAlbumEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'textEmpty'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #'event handling' }
ToAlbumEventHandler >> blurEvent: aBlurEvent [

	| target |
	target := aBlurEvent currentTarget.
	target border: target defaultBlurBorder
]

{ #category : #'event handling' }
ToAlbumEventHandler >> checkTextIn: anEditorElement [

	(textEmpty isNil or: [ anEditorElement text isEmpty ~= textEmpty ])
		ifTrue: [
		anEditorElement dispatchEvent: ToTextEmptinessChangeEvent new ].
	textEmpty := anEditorElement text isEmpty
]

{ #category : #'event handling' }
ToAlbumEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self checkTextIn: target
]

{ #category : #'api - accessing' }
ToAlbumEventHandler >> eventsToHandle [

	^ {
		  BlElementAddedToSceneGraphEvent.
		  AlbTextEditedEvent.
		  AlbTextReplacedEvent.
		  "BlBlurEvent.
		  BlFocusEvent."
		  ToTextEmptinessChangeEvent }
]

{ #category : #'event handling' }
ToAlbumEventHandler >> focusEvent: aFocusEvent [

	| target |
	target := aFocusEvent currentTarget.
	target border: target defaultFocusBorder
]

{ #category : #'event handling' }
ToAlbumEventHandler >> textEditedEvent: aTextEditedEvent [

	aTextEditedEvent currentTarget edited: true.
	self checkTextIn: aTextEditedEvent currentTarget.
	aTextEditedEvent currentTarget requestTextStyle.
]

{ #category : #'event handling' }
ToAlbumEventHandler >> textEmptinessChangeEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target text
		ifEmpty: [ target showPlaceholder ]
		ifNotEmpty: [ target hidePlaceholder ]
]

{ #category : #'event handling' }
ToAlbumEventHandler >> textReplacedEvent: aTextReplacedEvent [

	self checkTextIn: aTextReplacedEvent currentTarget.
	aTextReplacedEvent currentTarget requestTextStyle.
]
