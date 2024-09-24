Class {
	#name : #ToAlbumPrimarySelectionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #'event handling' }
ToAlbumPrimarySelectionElementSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e valueOfTokenNamed: #'color-primary-selection-disabled').
		e background:
			(e valueOfTokenNamed: #'color-primary-selection-disabled') ]
]

{ #category : #'event handling' }
ToAlbumPrimarySelectionElementSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background:
			(e valueOfTokenNamed: #'color-primary-selection-focused') ]
]

{ #category : #'event handling' }
ToAlbumPrimarySelectionElementSkin >> focusedSkinEvent: anEvent [

	super focusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background:
			(e valueOfTokenNamed: #'color-primary-selection-focused') ]
]

{ #category : #'event handling' }
ToAlbumPrimarySelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e valueOfTokenNamed: #'color-primary-selection-focused') ]
]

{ #category : #'event handling' }
ToAlbumPrimarySelectionElementSkin >> unfocusedSkinEvent: anEvent [

	super unfocusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isEnabled ifTrue: [
			e border: (e valueOfTokenNamed: #'color-primary-selection-focused').
			e background:
				(e valueOfTokenNamed: #'color-primary-selection-unfocused') ] ]
]
