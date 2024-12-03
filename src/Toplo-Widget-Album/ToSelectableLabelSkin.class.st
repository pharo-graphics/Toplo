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
ToSelectableLabelSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isEnabled
			ifTrue: [ e mouseCursor: Cursor overEditableText ]
			ifFalse: [ e mouseCursor: Cursor normal ] ]
]

{ #category : #'event handling' }
ToSelectableLabelSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e margin: BlInsets empty ]
]
