Class {
	#name : #ToAlbumBasicDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-Album'
}

{ #category : #initialization }
ToAlbumBasicDresser >> defaultMargin [

	^ BlInsets all: 1
]

{ #category : #initialization }
ToAlbumBasicDresser >> defaultPadding [

	^ BlInsets
		  top: 2
		  left: 3
		  bottom: 2
		  right: 2
]

{ #category : #'api - install/uninstall  hook' }
ToAlbumBasicDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 8).
	
	anElement margin: self defaultMargin.
	anElement padding: self defaultPadding.

	anElement infinite
		when: BlBlurEvent
		do: [ :anEvent | 
			anElement border: (BlBorder
					 paint: anElement theme editor borderColor
					 width: 1) ].
	anElement infinite
		when: BlFocusEvent
		do: [ :anEvent | 
			anElement  border: (BlBorder
					 paint: anElement theme editor focusedBorderColor
					 width: 1) ].

	anElement  border: (BlBorder
			 paint: anElement theme editor borderColor
			 width: 1).

	anElement  background: Color white
]
