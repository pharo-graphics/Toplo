Class {
	#name : #ToImageLinkLook,
	#superclass : #ToImageLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #accessing }
ToImageLinkLook >> foregroundHoverFromElement: anElement [

	^ anElement toTheme colorLinkHover
]

{ #category : #accessing }
ToImageLinkLook >> foregroundInitialFromElement: anElement [

	^ anElement toTheme colorLink
]

{ #category : #'event handling' }
ToImageLinkLook >> hoverStateEvent: anEvent [

	super hoverStateEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := self foregroundHoverFromElement: e.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToImageLinkLook >> pressedStateEvent: anEvent [

	super pressedStateEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := self foregroundPressedFromElement: e.
		self adaptForegroundIn: e withColor: c ]
]
