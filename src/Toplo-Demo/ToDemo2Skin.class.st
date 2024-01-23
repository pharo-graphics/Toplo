Class {
	#name : #ToDemo2Skin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Demo-1-Basic'
}

{ #category : #'event handling' }
ToDemo2Skin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: Color blue.
		e size: 50 @ 50 ]
]
