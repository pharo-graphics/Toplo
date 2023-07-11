Class {
	#name : #ToButtonImageLook,
	#superclass : #ToImageLookDecorator,
	#category : #'Toplo-Widget-Image-Look'
}

{ #category : #'event handling' }
ToButtonImageLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorPrimary.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToButtonImageLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorPrimaryPressed.
		self adaptForegroundIn: e withColor: c ]
]
