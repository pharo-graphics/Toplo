Class {
	#name : #ToDemo7ButterflySkin1,
	#superclass : #ToButterflySkin,
	#category : #'Toplo-Demo-2 - ButterflyTheme'
}

{ #category : #'event handling' }
ToDemo7ButterflySkin1 >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: Color red.
		e fitContent.
		e padding: (BlInsets all: 5).
		e dem6 defaultButterflySkin: ToDemoButterflySkin1 new ]
]
