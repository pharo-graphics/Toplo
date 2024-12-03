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
