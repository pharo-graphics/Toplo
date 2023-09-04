Class {
	#name : #ToBoundsLook,
	#superclass : #ToDefaultElementLook,
	#category : #'Toplo-Core-Theme-Looks'
}

{ #category : #'event handling' }
ToBoundsLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		]
]
