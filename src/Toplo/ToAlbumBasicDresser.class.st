Class {
	#name : #ToAlbumBasicDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-Album'
}

{ #category : #'api - install/uninstall  hook' }
ToAlbumBasicDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement innerElement geometry: (BlRoundedRectangleGeometry cornerRadius: 8).
	anElement innerElement
		when: BlBlurEvent
		do: [ :anEvent | 
			anElement innerElement border: (BlBorder
					 paint: anElement theme editor borderColor
					 width: 1) ].
	anElement innerElement
		when: BlFocusEvent
		do: [ :anEvent | 
			anElement innerElement border: (BlBorder
					 paint: anElement theme editor focusedBorderColor
					 width: 1) ].

	anElement innerElement border: (BlBorder
			 paint: anElement theme editor borderColor
			 width: 1).

	anElement innerElement background: Color white
]
