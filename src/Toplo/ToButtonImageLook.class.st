Class {
	#name : #ToButtonImageLook,
	#superclass : #ToImageLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'event handling' }
ToButtonImageLook >> hoverLookEvent: anEvent [

	super hoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorPrimary.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToButtonImageLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorPrimaryPressed.
		self adaptForegroundIn: e withColor: c ]
]
