Class {
	#name : #ToTabBarSelectionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Incubator'
}

{ #category : #'event handling' }
ToTabBarSelectionElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | | bnds |
		bnds := e boundsFromNodes.
		e size: bnds extent x @ 3.
		e position: bnds origin x @ (bnds origin y + e nodes first height).
		e background: (e valueOfTokenNamed: #'color-primary-selection-focused') ]
]
