Class {
	#name : #ToImageDangerLook,
	#superclass : #ToImageLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #accessing }
ToImageDangerLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorError.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #accessing }
ToImageDangerLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorError.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #accessing }
ToImageDangerLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
			| c |
			c := e toTheme colorErrorHover.
			self adaptForegroundIn: e withColor: c ]
]

{ #category : #accessing }
ToImageDangerLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorError darker.
		self adaptForegroundIn: e withColor: c ]
]
