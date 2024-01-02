Class {
	#name : #ToAlbumPrimarySelectionElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #'event handling' }
ToAlbumPrimarySelectionElementEventHandler >> blurEvent: anEvent [

	anEvent currentTarget focused: false
]

{ #category : #'api - accessing' }
ToAlbumPrimarySelectionElementEventHandler >> eventsToHandle [

	^ {
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

	| target |
	target := anEvent currentTarget.
	target hasFocus 
		ifTrue: [ target editorElement dispatchEvent: anEvent ]
		ifFalse: [ target dispatchEvent: BlFocusEvent new].
	
]

{ #category : #'mouse handlers' }
ToAlbumPrimarySelectionElementEventHandler >> mouseUpEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target editorElement dispatchEvent: anEvent 
]
