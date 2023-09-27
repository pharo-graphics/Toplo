Class {
	#name : #ToAlbumEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #'event handling' }
ToAlbumEventHandler >> blurEvent: aBlurEvent [

	| target |
	target := aBlurEvent currentTarget.
	target next border: (BlBorder
			 paint: target defaultBorderColor
			 width: target defaultBorderWidth)
]

{ #category : #'event handling' }
ToAlbumEventHandler >> checkTextIn: anEditorElement [

	anEditorElement text
		ifEmpty: [ anEditorElement showPlaceholder ]
		ifNotEmpty: [ anEditorElement hidePlaceholder ]
]

{ #category : #'api - accessing' }
ToAlbumEventHandler >> eventsToHandle [

	^ {
		  AlbTextEditedEvent.
		  AlbTextReplacedEvent.
		  BlBlurEvent.
		  BlFocusEvent }
]

{ #category : #'event handling' }
ToAlbumEventHandler >> focusEvent: aFocusEvent [

	| target |
	target := aFocusEvent currentTarget.
	target next border: target defaultFocusBorder
]

{ #category : #'event handling' }
ToAlbumEventHandler >> textEditedEvent: aTextEditedEvent [

	aTextEditedEvent currentTarget edited: true.
	self checkTextIn: aTextEditedEvent currentTarget
]

{ #category : #'event handling' }
ToAlbumEventHandler >> textReplacedEvent: aTextReplacedEvent [

	self checkTextIn: aTextReplacedEvent currentTarget
]
