Class {
	#name : #ToSelectTextFieldSkin,
	#superclass : #ToAlbumSkin,
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #accessing }
ToSelectTextFieldSkin >> blurBorderIn: anAlbum [

	^ BlBorder empty
]

{ #category : #accessing }
ToSelectTextFieldSkin >> focusBorderIn: anAlbum [

	^ BlBorder empty
]

{ #category : #'event handling' }
ToSelectTextFieldSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: BlBackground transparent ]
]
