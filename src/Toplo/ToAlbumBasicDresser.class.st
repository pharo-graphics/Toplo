Class {
	#name : #ToAlbumBasicDresser,
	#superclass : #OBlElementCompanion,
	#category : #'Toplo-Widget-Album'
}

{ #category : #'api - hooks' }
ToAlbumBasicDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement editorElement geometry: (BlRoundedRectangleGeometry cornerRadius: 6).
	anElement editorElement
		when: BlBlurEvent
		do: [ :anEvent | 
			anElement editorElement border: (BlBorder
					 paint: anElement theme editor borderColor
					 width: 1) ].
	anElement editorElement
		when: BlFocusEvent
		do: [ :anEvent | 
			anElement editorElement border: (BlBorder
					 paint: anElement theme editor focusedBorderColor
					 width: 2) ].

	anElement editorElement border: (BlBorder
			 paint: anElement theme editor borderColor
			 width: 1).

	anElement editorElement background: Color white
]
