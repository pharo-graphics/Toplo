Class {
	#name : #ToImageLinkLook,
	#superclass : #ToImageLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

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
ToImageLinkLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorLinkHover.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToImageLinkLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorPrimaryPressed.
		self adaptForegroundIn: e withColor: c ]
]
