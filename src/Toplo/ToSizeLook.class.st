Class {
	#name : #ToSizeLook,
	#superclass : #ToDefaultElementLook,
	#category : #'Toplo-Core-Theme-Looks'
}

{ #category : #'event handling' }
ToSizeLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		]
]
