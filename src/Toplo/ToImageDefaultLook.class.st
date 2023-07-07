Class {
	#name : #ToImageDefaultLook,
	#superclass : #ToImageLook,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'event handling' }
ToImageDefaultLook >> hoverLookEvent: anEvent [

	super hoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
			| c |
			c := e toTheme colorPrimary.
			self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToImageDefaultLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
			| c |
			c := e toTheme colorImage.
			self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToImageDefaultLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
			| c |
			c := e toTheme colorImage.
			self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToImageDefaultLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorPrimaryPressed.
		self adaptForegroundIn: e withColor: c ]
]
