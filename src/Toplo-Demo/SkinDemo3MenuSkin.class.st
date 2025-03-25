Class {
	#name : #SkinDemo3MenuSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Demo-Skin Demo - 3'
}

{ #category : #'event handling' }
SkinDemo3MenuSkin >> clickedSkinEvent: anEvent [

	super clickedSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		|container|
		container := elt container.
		container isVisible
			ifTrue: [ container visibility: BlVisibility gone ]
			ifFalse: [ container visibility: BlVisibility visible ] ]
]

{ #category : #'event handling' }
SkinDemo3MenuSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt background: (elt valueOfTokenNamed: #'background-not-clicked-hovered'). ]
]

{ #category : #'event handling' }
SkinDemo3MenuSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt background: (elt valueOfTokenNamed: #'background-not-clicked').

		elt geometry: (BlRoundedRectangleGeometry cornerRadius: 5).

		elt border: (BlBorder
				 paint: (elt valueOfTokenNamed: #'border-paint')
				 width: (elt valueOfTokenNamed: #'border-radius')) ]
]

{ #category : #'event handling' }
SkinDemo3MenuSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt background:
			(elt valueOfTokenNamed: #'background-not-clicked') ]
]
