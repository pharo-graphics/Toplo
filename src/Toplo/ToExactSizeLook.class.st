Class {
	#name : #ToExactSizeLook,
	#superclass : #ToDefaultElementLook,
	#category : #'Toplo-Core-Theme-Looks'
}

{ #category : #'event handling' }
ToExactSizeLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e height: e toTheme controlHeight]
]
