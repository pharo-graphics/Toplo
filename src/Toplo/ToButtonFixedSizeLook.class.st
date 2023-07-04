Class {
	#name : #ToButtonFixedSizeLook,
	#superclass : #ToButtonLookDecorator,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #'event handling' }
ToButtonFixedSizeLook >> initialStateEvent: anEvent [

	super initialStateEvent: anEvent.
	anEvent elementDo: [ :e |
		e height: e toTheme controlHeight]
]
