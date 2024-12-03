Class {
	#name : #ToSelectableLabelSkin,
	#superclass : #ToAlbumSkin,
	#category : #'Toplo-Widget-Album-TextField'
}

{ #category : #accessing }
ToSelectableLabelSkin >> blurBorderIn: anAlbum [

	^ BlBorder
		  paint: Color transparent
		  width: (anAlbum valueOfTokenNamed: #'border-width')
]

{ #category : #accessing }
ToSelectableLabelSkin >> focusBorderIn: anAlbum [

	^ BlBorder
		  paint: Color transparent
		  width: (anAlbum valueOfTokenNamed: #'focus-border-width')
]

{ #category : #'event handling' }
ToSelectableLabelSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | e margin: BlInsets empty ]
]
