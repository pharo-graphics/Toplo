Class {
	#name : #ToLayoutLook,
	#superclass : #ToElementLook,
	#category : #'Toplo-Theme-Look'
}

{ #category : #'event handling' }
ToLayoutLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		]
]
