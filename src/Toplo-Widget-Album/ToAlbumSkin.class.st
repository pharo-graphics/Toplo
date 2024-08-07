Class {
	#name : #ToAlbumSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #accessing }
ToAlbumSkin >> blurBorderIn: anAlbum [

	^ BlBorder
		  paint: (anAlbum valueOfTokenNamed: #'border-paint')
		  width: (anAlbum valueOfTokenNamed: #'border-width')
]

{ #category : #accessing }
ToAlbumSkin >> focusBorderIn: anAlbum [

	^ BlBorder
		  paint: (anAlbum valueOfTokenNamed: #'focus-border-paint')
		  width: (anAlbum valueOfTokenNamed: #'focus-border-width')
]

{ #category : #'event handling' }
ToAlbumSkin >> focusedSkinEvent: anEvent [

	super focusedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: (self focusBorderIn: e) ]
]

{ #category : #'event handling' }
ToAlbumSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isEditable
			ifTrue: [ e mouseCursor: Cursor overEditableText ]
			ifFalse: [ e mouseCursor: Cursor normal ] ]
]

{ #category : #'event handling' }
ToAlbumSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		(e hasStamp: #placeholder) ifTrue: [
			e text
				fontSize: 24;
				foreground: Color gray lighter ].
		e border: (self blurBorderIn: e).
		e background: (e valueOfTokenNamed: #'color-bg-container').
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius')).
		e margin: BlInsets empty.
		e outskirts: BlOutskirts inside.
		e padding: (BlInsets
				 top: (e valueOfTokenNamed: #'padding-content-V')
				 left: (e valueOfTokenNamed: #'padding-XS')
				 bottom: (e valueOfTokenNamed: #'padding-content-V')
				 right: (e valueOfTokenNamed: #'padding-XS')) ]
]

{ #category : #'event handling' }
ToAlbumSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e mouseCursor: Cursor normal ]
]

{ #category : #'event handling' }
ToAlbumSkin >> unfocusedSkinEvent: anEvent [

	super unfocusedSkinEvent: anEvent.
	anEvent elementDo: [ :e | e border: (self blurBorderIn: e) ]
]
