Class {
	#name : #ToSelectFilterTextFieldSkin,
	#superclass : #ToAlbumSkin,
	#category : #'Toplo-Widget-Select-textInput'
}

{ #category : #accessing }
ToSelectFilterTextFieldSkin >> blurBorderIn: anAlbum [

	^ BlBorder empty
]

{ #category : #accessing }
ToSelectFilterTextFieldSkin >> focusBorderIn: anAlbum [

	^ BlBorder empty
]

{ #category : #'event handling' }
ToSelectFilterTextFieldSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: BlBackground transparent ]
]
