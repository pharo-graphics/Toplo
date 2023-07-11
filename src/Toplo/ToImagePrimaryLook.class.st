Class {
	#name : #ToImagePrimaryLook,
	#superclass : #ToImageMainLook,
	#category : #'Toplo-Widget-Image-Look'
}

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
ToImagePrimaryLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorImageLightSolid.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #accessing }
ToImagePrimaryLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorImageLightSolid.
		self adaptForegroundIn: e withColor: c ]
]
