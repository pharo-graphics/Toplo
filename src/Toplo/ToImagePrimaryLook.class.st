Class {
	#name : #ToImagePrimaryLook,
	#superclass : #ToImageLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #accessing }
ToImagePrimaryLook >> foregroundInitialFromElement: anElement [

	^ anElement toTheme colorImageLightSolid
]

{ #category : #accessing }
ToImagePrimaryLook >> installStateEvent: anEvent [

	super installStateEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := self foregroundInitialFromElement: e.
		self adaptForegroundIn: e withColor: c ]
]
