Class {
	#name : #ToAlbumPrimarySelectionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #'event handling' }
ToAlbumPrimarySelectionElementSkin >> focusedLookEvent: anEvent [

	super focusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-primary-selection-focused') ]
]

{ #category : #'event handling' }
ToAlbumPrimarySelectionElementSkin >> focusedSkinEvent: anEvent [

	super focusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-primary-selection-focused') ]
]

{ #category : #'event handling' }
ToAlbumPrimarySelectionElementSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		 e border: (e valueOfTokenNamed: #'color-primary-selection-focused') ]
]

{ #category : #'event handling' }
ToAlbumPrimarySelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: (e valueOfTokenNamed: #'color-primary-selection-focused') ]
]

{ #category : #'event handling' }
ToAlbumPrimarySelectionElementSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		 e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToAlbumPrimarySelectionElementSkin >> unfocusedSkinEvent: anEvent [

	super unfocusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-primary-selection-unfocused') ]
]
