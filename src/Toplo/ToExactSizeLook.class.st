Class {
	#name : #ToExactSizeLook,
	#superclass : #ToElementLook,
	#category : #'Toplo-Core-Theme-Looks'
}

{ #category : #'event handling' }
ToExactSizeLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e height: e toTheme controlHeight]
]
