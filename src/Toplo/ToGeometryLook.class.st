Class {
	#name : #ToGeometryLook,
	#superclass : #ToDefaultElementLook,
	#category : #'Toplo-Core-Theme-Looks'
}

{ #category : #'event handling' }
ToGeometryLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		]
]
