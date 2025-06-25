Class {
	#name : #ToSkinDemo2ButtonSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Demo-Skin Demo - 2'
}

{ #category : #'event handling' }
ToSkinDemo2ButtonSkin >> clickedSkinEvent: anEvent [

	super clickedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e clicked
				 ifTrue: [ Color lightGreen darker ]
				 ifFalse: [ Color lightRed darker ]) ]
]

{ #category : #'event handling' }
ToSkinDemo2ButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt background: (elt clicked
				 ifTrue: [ Color lightGreen darker ]
				 ifFalse: [ Color lightRed darker ]) ]
]

{ #category : #'event handling' }
ToSkinDemo2ButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :elt |
		elt size: 100 @ 50.
		elt margin: (BlInsets all: 2).
		elt background: (elt clicked
				 ifTrue: [ Color lightGreen ]
				 ifFalse: [ Color lightRed ]).

		elt geometry: (BlRoundedRectangleGeometry cornerRadius: 5) ]
]

{ #category : #'event handling' }
ToSkinDemo2ButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e clicked
				 ifTrue: [ Color lightGreen ]
				 ifFalse: [ Color lightRed ]) ]
]

{ #category : #'event handling' }
ToSkinDemo2ButtonSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e clicked
				 ifTrue: [ Color lightGreen ]
				 ifFalse: [ Color lightRed ]) ]
]
