Class {
	#name : #ToAlbumEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'textEmpty'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #'event handling' }
ToAlbumEventHandler >> checkTextIn: anEditorElement [

	(textEmpty isNil or: [ anEditorElement text isEmpty ~= textEmpty ])
		ifTrue: [
		anEditorElement dispatchEvent: ToTextEmptinessChangeEvent new ].
	textEmpty := anEditorElement text isEmpty
]

{ #category : #'mouse handlers' }
ToAlbumEventHandler >> doubleClickEvent: anEvent [

	anEvent currentTarget infinite dispatchEvent: anEvent copy
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
		  BlMouseDownEvent.
		  BlDoubleClickEvent.
		  BlElementAddedToSceneGraphEvent.
		  AlbTextEditedEvent.
		  AlbTextReplacedEvent.
		  ToTextEmptinessChangeEvent }
]

{ #category : #'mouse handlers' }
ToAlbumEventHandler >> mouseDownEvent: anEvent [

	" copy the event, else the double click can't works "
	anEvent currentTarget infinite dispatchEvent: anEvent copy
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
