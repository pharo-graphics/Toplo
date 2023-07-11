Class {
	#name : #ToImageDefaultLook,
	#superclass : #ToImageMainLook,
	#category : #'Toplo-Widget-Image-Look'
}

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
