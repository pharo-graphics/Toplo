Class {
	#name : #ToAlbumPrimarySelectionElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'prevMouseDownEvent'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #'event handling' }
ToAlbumPrimarySelectionElementEventHandler >> blurEvent: anEvent [

	anEvent currentTarget focused: false
]

{ #category : #'dnd handlers' }
ToAlbumPrimarySelectionElementEventHandler >> dragEvent: anEvent [

	anEvent consume
]

{ #category : #'dnd handlers' }
ToAlbumPrimarySelectionElementEventHandler >> dragStartEvent: anEvent [

	anEvent consume
]

{ #category : #'api - accessing' }
ToAlbumPrimarySelectionElementEventHandler >> eventsToHandle [

	^ {
		  BlDragStartEvent.
		  BlDragEvent.
		  BlMouseDownEvent.
		  BlMouseUpEvent.
		  BlFocusEvent.
		  BlBlurEvent }
]

{ #category : #'event handling' }
ToAlbumPrimarySelectionElementEventHandler >> focusEvent: anEvent [

	anEvent currentTarget focused: true
]

{ #category : #'mouse handlers' }
ToAlbumPrimarySelectionElementEventHandler >> mouseDownEvent: anEvent [

	anEvent
		  ifPrimary: [ self primaryMouseDownEvent: anEvent ]
		  secondary: [ self secondaryMouseDownEvent: anEvent ]
		  middle: [  ]
		  other: [  ]
]

{ #category : #'mouse handlers' }
ToAlbumPrimarySelectionElementEventHandler >> mouseUpEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	prevMouseDownEvent ifNotNil: [
		prevMouseDownEvent consumed: false.
		target editorElement dispatchEvent: prevMouseDownEvent.
		"target editorElement dispatchEvent: anEvent."
		prevMouseDownEvent := nil ]
]

{ #category : #'mouse handlers' }
ToAlbumPrimarySelectionElementEventHandler >> primaryMouseDownEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target hasFocus
		ifTrue: [
			anEvent consume.
			prevMouseDownEvent := anEvent "target editorElement dispatchEvent: anEvent" ]
		ifFalse: [ target dispatchEvent: BlFocusEvent new ]
]

{ #category : #'mouse handlers' }
ToAlbumPrimarySelectionElementEventHandler >> secondaryMouseDownEvent: anEvent [

	
]
