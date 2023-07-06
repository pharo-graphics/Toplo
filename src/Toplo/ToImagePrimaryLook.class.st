Class {
	#name : #ToImagePrimaryLook,
	#superclass : #ToImageLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #accessing }
ToImagePrimaryLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := e toTheme colorImageLightSolid.
		self adaptForegroundIn: e withColor: c ]
]
