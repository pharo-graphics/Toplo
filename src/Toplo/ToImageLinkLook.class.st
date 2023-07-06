Class {
	#name : #ToImageLinkLook,
	#superclass : #ToImageLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'event handling' }
ToImageLinkLook >> hoverLookEvent: anEvent [

	super hoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorLinkHover.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToImageLinkLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorLink.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToImageLinkLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorLink.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToImageLinkLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorImage.
		self adaptForegroundIn: e withColor: c ]
]
