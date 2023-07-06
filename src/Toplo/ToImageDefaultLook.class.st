Class {
	#name : #ToImageDefaultLook,
	#superclass : #ToImageLook,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'event handling' }
ToImageDefaultLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	"anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorImage.
		self adaptForegroundIn: e withColor: c ]"
]
