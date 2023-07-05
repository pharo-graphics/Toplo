Class {
	#name : #ToButtonImageLook,
	#superclass : #ToImageLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #accessing }
ToButtonImageLook >> foregroundHoverFromElement: anElement [

	^ anElement toTheme colorPrimary
]

{ #category : #accessing }
ToButtonImageLook >> foregroundPressedFromElement: anElement [

	^ anElement toTheme colorPrimaryPressed
]

{ #category : #'event handling' }
ToButtonImageLook >> hoverStateEvent: anEvent [

	super hoverStateEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := self foregroundHoverFromElement: e.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToButtonImageLook >> pressedStateEvent: anEvent [

	super pressedStateEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := self foregroundPressedFromElement: e.
		self adaptForegroundIn: e withColor: c ]
]
