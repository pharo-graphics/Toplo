Class {
	#name : #ToGeometryLook,
	#superclass : #ToDefaultElementLook,
	#category : #'Toplo-Theme-Look'
}

{ #category : #'event handling' }
ToGeometryLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		]
]
