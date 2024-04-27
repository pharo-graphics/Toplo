Class {
	#name : #ToTabBarSelectionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Incubator'
}

{ #category : #'event handling' }
ToTabBarSelectionElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background:
			(e valueOfTokenNamed: #'color-primary-selection-focused') ]
]
