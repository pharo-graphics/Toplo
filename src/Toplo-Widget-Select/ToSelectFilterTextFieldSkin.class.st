Class {
	#name : #ToSelectFilterTextFieldSkin,
	#superclass : #ToAlbumSkin,
	#category : #'Toplo-Widget-Select-Filter-TextField'
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
			e geometry: BlRectangleGeometry new.
			e selectElement isFiltrable
				ifTrue: [
						e padding: (BlInsets horizontal: 3 vertical: 3).
						e background: (e valueOfTokenNamed: #'color-border') ]
				ifFalse: [
						e padding: BlInsets empty.
						e background: Color transparent ] ]
]
