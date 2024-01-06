Class {
	#name : #ToSpaceRootSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Core-Skin'
}

{ #category : #'event handling' }
ToSpaceRootSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.

	anEvent elementDo: [ :e |
		e background: (e tokenValueNamed: #'background-color') ]
]
