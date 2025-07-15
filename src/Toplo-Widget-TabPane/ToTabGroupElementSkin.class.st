Class {
	#name : #ToTabGroupElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #'event handling' }
ToTabGroupElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: Color transparent.
		e border: BlBorder empty.
		e startInterspace: (e valueOfTokenNamed: #'button-interspace').
		e endInterspace: (e valueOfTokenNamed: #'button-interspace') ]
]
