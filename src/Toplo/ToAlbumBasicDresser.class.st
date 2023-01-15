Class {
	#name : #ToAlbumBasicDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-Album'
}

{ #category : #'api - install/uninstall  hook' }
ToAlbumBasicDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement next geometry: (BlRoundedRectangleGeometry cornerRadius: 8).
	anElement infinite
		when: BlBlurEvent
		do: [ :anEvent | 
			anElement next border: (BlBorder
					 paint: anElement theme editor borderColor
					 width: 1) ].
	anElement infinite
		when: BlFocusEvent
		do: [ :anEvent | 
			anElement next border: (BlBorder
					 paint: anElement theme editor focusedBorderColor
					 width: 1) ].

	anElement next border: (BlBorder
			 paint: anElement theme editor borderColor
			 width: 1).

	anElement infinite background: Color white
]
