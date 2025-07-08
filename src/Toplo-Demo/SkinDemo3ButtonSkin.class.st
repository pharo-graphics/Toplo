Class {
	#name : #SkinDemo3ButtonSkin,
	#superclass : #ToSkinDemoSkin,
	#category : #'Toplo-Demo-Skin Demo - 3'
}

{ #category : #'event handling' }
SkinDemo3ButtonSkin >> clickedSkinEvent: anEvent [

	super clickedSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt background: (elt clicked
				 ifTrue: [ elt valueOfTokenNamed: #'background-clicked-hovered' ]
				 ifFalse: [ elt valueOfTokenNamed: #'background-not-clicked-hovered' ]) ]
]

{ #category : #'event handling' }
SkinDemo3ButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt background: (elt clicked
			ifTrue: [ elt valueOfTokenNamed: #'background-clicked-hovered' ]
			ifFalse: [ elt valueOfTokenNamed: #'background-not-clicked-hovered' ]) ]
]

{ #category : #'event handling' }
SkinDemo3ButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt extent: 100 @ 50.
		elt margin: (BlInsets all: 2).
		elt background: (elt clicked
				 ifTrue: [ elt valueOfTokenNamed: #'background-clicked' ]
				 ifFalse: [ elt valueOfTokenNamed: #'background-not-clicked' ]).

		elt geometry: (BlRoundedRectangleGeometry cornerRadius: 5).

		elt border: (BlBorder
				 paint: (elt valueOfTokenNamed: #'border-paint')
				 width: (elt valueOfTokenNamed: #'border-radius')) ]
]

{ #category : #'event handling' }
SkinDemo3ButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt background: (elt clicked
				 ifTrue: [ elt valueOfTokenNamed: #'background-clicked' ]
				 ifFalse: [ elt valueOfTokenNamed: #'background-not-clicked' ]) ]
]

{ #category : #'event handling' }
SkinDemo3ButtonSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt background: (elt clicked
				 ifTrue: [ elt valueOfTokenNamed: #'background-clicked' ]
				 ifFalse: [ elt valueOfTokenNamed: #'background-not-clicked' ]) ]
]
