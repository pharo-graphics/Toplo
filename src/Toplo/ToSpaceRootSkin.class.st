Class {
	#name : #ToSpaceRootSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Core-Skin'
}

{ #category : #'event handling' }
ToSpaceRootSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.

	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'background-color') ]
]
