Class {
	#name : #ToButtonImageDangerLook,
	#superclass : #ToImageLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #accessing }
ToButtonImageDangerLook >> hoverLookEvent: anEvent [

	super hoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorErrorHover.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #accessing }
ToButtonImageDangerLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorError.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #accessing }
ToButtonImageDangerLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorError.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #accessing }
ToButtonImageDangerLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorError darker.
		self adaptForegroundIn: e withColor: c ]
]
