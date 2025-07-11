Class {
	#name : #ToSelectFilterTextFieldSkin,
	#superclass : #ToAlbumSkin,
	#category : #'Toplo-Widget-Select-Filter-TextField'
}

{ #category : #accessing }
ToSelectFilterTextFieldSkin >> blurBorderIn: e [ 

	^ e selectElement isFiltrable
				ifTrue: [ e valueOfTokenNamed: #'color-border' ]
				ifFalse: [ BlBorder empty ]
]

{ #category : #accessing }
ToSelectFilterTextFieldSkin >> focusBorderIn: e [

	^ e selectElement isFiltrable
				ifTrue: [ e valueOfTokenNamed: #'color-border' ]
				ifFalse: [ BlBorder empty ]
]

{ #category : #'event handling' }
ToSelectFilterTextFieldSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e selectElement isFiltrable
				ifTrue: [ e padding: (BlInsets horizontal: 6 vertical: 3) ]
				ifFalse: [ e padding: BlInsets empty ] ]
]
