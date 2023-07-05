Class {
	#name : #ToButtonFixedSizeLook,
	#superclass : #ToButtonLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'event handling' }
ToButtonFixedSizeLook >> initialStateEvent: anEvent [

	super initialStateEvent: anEvent.
	anEvent elementDo: [ :e |
		e height: e toTheme controlHeight]
]

{ #category : #'event handling' }
ToButtonFixedSizeLook >> installStateEvent: anEvent [

	super installStateEvent: anEvent.
	anEvent elementDo: [ :e |
		e height: e toTheme controlHeight]
]
