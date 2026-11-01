Class {
	#name : #ToSkinDemo1ButtonSkin,
	#superclass : #ToRawSkin,
	#instVars : [
		'clicked'
	],
	#category : #'Toplo-Demo-Skin Demo - 1'
}

{ #category : #'event handling' }
ToSkinDemo1ButtonSkin >> clickedSkinEvent: anEvent [

	super clickedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		clicked := clicked not.
		e background: (clicked
			 ifTrue: [ Color lightGreen ]
			 ifFalse: [ Color lightRed ]) ]
]

{ #category : #'event handling' }
ToSkinDemo1ButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e extent: 100 @ 50.
		e geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
		e background: Color lightRed.
		e margin: (BlInsets all: 2).
		clicked := false ]
]
