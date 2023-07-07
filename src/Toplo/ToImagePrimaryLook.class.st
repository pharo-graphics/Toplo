Class {
	#name : #ToImagePrimaryLook,
	#superclass : #ToImageLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #accessing }
ToImagePrimaryLook >> hoverLookEvent: anEvent [

	super hoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorImageLightSolid.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #accessing }
ToImagePrimaryLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorImageLightSolid.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #accessing }
ToImagePrimaryLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorImageLightSolid.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #accessing }
ToImagePrimaryLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorImageLightSolid.
		self adaptForegroundIn: e withColor: c ]
]
