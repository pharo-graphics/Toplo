Class {
	#name : #ToSelectTextFieldSkin,
	#superclass : #ToAlbumSkin,
	#category : #'Toplo-Widget-Select-textInput'
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
ToSelectTextFieldSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: BlBackground transparent ]
]
