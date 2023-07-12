Class {
	#name : #ToExactSizeLook,
	#superclass : #ToElementLook,
	#category : #'Toplo-Core-Theme-Skins'
}

{ #category : #'event handling' }
ToExactSizeLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e height: e toTheme controlHeight]
]

{ #category : #'event handling' }
ToExactSizeLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e height: e toTheme controlHeight]
]
