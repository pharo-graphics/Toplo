Class {
	#name : #ToButtonFixedSizeLook,
	#superclass : #ToButtonLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'event handling' }
ToButtonFixedSizeLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e height: e toTheme controlHeight]
]

{ #category : #'event handling' }
ToButtonFixedSizeLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e height: e toTheme controlHeight]
]
