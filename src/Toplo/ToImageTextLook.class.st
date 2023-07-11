Class {
	#name : #ToImageTextLook,
	#superclass : #ToImageLookDecorator,
	#category : #'Toplo-Widget-Image-Look'
}

{ #category : #'event handling' }
ToImageTextLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorText.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToImageTextLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorText.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToImageTextLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorText.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToImageTextLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorText.
		self adaptForegroundIn: e withColor: c ]
]
