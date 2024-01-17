Class {
	#name : #ToAlbumSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #accessing }
ToAlbumSkin >> blurBorderIn: anAlbum [

	^ BlBorder
		  paint: (anAlbum tokenValueNamed: #'border-paint')
		  width: (anAlbum tokenValueNamed: #'border-width')
]

{ #category : #accessing }
ToAlbumSkin >> focusBorderIn: anAlbum [

	^ BlBorder
		  paint: (anAlbum tokenValueNamed: #'focus-border-paint')
		  width: (anAlbum tokenValueNamed: #'focus-border-width')
]

{ #category : #'event handling' }
ToAlbumSkin >> focusedLookEvent: anEvent [

	super focusedLookEvent: anEvent.
	anEvent elementDo: [ :e | e border: (self focusBorderIn: e) ]
]

{ #category : #'event handling' }
ToAlbumSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e isEditable
			ifTrue: [ e mouseCursor: Cursor overEditableText ]
			ifFalse: [ e mouseCursor: Cursor normal ] ]
]

{ #category : #'event handling' }
ToAlbumSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (self blurBorderIn: e).
		e background: (e tokenValueNamed: #'color-bg-container').
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e tokenValueNamed: 'border-radius')).
		e margin: BlInsets empty.
		e outskirts: BlOutskirts inside.
		e padding: (BlInsets
				 horizontal: (e tokenValueNamed: #'text-editor-padding-H')
				 vertical: (e tokenValueNamed: #'text-editor-padding-V')) ]
]

{ #category : #'event handling' }
ToAlbumSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e | e mouseCursor: Cursor normal ]
]

{ #category : #'event handling' }
ToAlbumSkin >> unfocusedLookEvent: anEvent [

	super unfocusedLookEvent: anEvent.
	anEvent elementDo: [ :e | e border: (self blurBorderIn: e) ]
]
