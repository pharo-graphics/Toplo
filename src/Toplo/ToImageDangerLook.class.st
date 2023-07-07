Class {
	#name : #ToImageDangerLook,
	#superclass : #ToImageLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #accessing }
ToImageDangerLook >> hoverLookEvent: anEvent [

	super hoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
			| c |
			c := e toTheme colorErrorHover.
			self adaptForegroundIn: e withColor: c ]
]

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
ToImageDangerLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorError darker.
		self adaptForegroundIn: e withColor: c ]
]
