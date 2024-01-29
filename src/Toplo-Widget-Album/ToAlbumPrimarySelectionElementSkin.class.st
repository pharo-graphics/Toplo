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
ToAlbumPrimarySelectionElementSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		 e border: (e valueOfTokenNamed: #'color-primary-selection-focused') ]
]

{ #category : #'event handling' }
ToAlbumPrimarySelectionElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToAlbumPrimarySelectionElementSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		 e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToAlbumPrimarySelectionElementSkin >> unfocusedLookEvent: anEvent [

	super unfocusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'color-primary-selection-unfocused') ]
]
