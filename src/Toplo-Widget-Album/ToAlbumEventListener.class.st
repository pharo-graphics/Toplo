Class {
	#name : #ToAlbumEventListener,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #'event handling' }
ToAlbumEventListener >> blurEvent: aBlurEvent [

	| target |
	target := aBlurEvent currentTarget.
	target next border: (BlBorder
			 paint: target defaultBorderColor
			 width: target defaultBorderWidth)
]

{ #category : #'event handling' }
ToAlbumEventListener >> checkTextIn: anEditorElement [

	anEditorElement text
		ifEmpty: [ anEditorElement showPlaceholder ]
		ifNotEmpty: [ anEditorElement hidePlaceholder ]
]

{ #category : #'api - accessing' }
ToAlbumEventListener >> eventsToHandle [

	^ {
		  AlbTextEditedEvent.
		  AlbTextReplacedEvent.
		  BlBlurEvent.
		  BlFocusEvent }
]

{ #category : #'event handling' }
ToAlbumEventListener >> focusEvent: aFocusEvent [

	| target |
	target := aFocusEvent currentTarget.
	target next border: target defaultFocusBorder
]

{ #category : #'event handling' }
ToAlbumEventListener >> textEditedEvent: aTextEditedEvent [

	aTextEditedEvent currentTarget edited: true.
	self checkTextIn: aTextEditedEvent currentTarget
]

{ #category : #'event handling' }
ToAlbumEventListener >> textReplacedEvent: aTextReplacedEvent [

	self checkTextIn: aTextReplacedEvent currentTarget
]
