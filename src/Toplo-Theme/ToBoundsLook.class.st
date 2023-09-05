Class {
	#name : #ToBoundsLook,
	#superclass : #ToDefaultElementLook,
	#category : #'Toplo-Theme-Look'
}

{ #category : #'event handling' }
ToBoundsLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		]
]
