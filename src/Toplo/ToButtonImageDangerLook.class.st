Class {
	#name : #ToButtonImageDangerLook,
	#superclass : #ToImageLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #accessing }
ToButtonImageDangerLook >> foregroundHoverFromElement: anElement [

	^ anElement toTheme colorErrorHover
]

{ #category : #accessing }
ToButtonImageDangerLook >> foregroundInitialFromElement: anElement [

	^ anElement toTheme colorError
]

{ #category : #accessing }
ToButtonImageDangerLook >> foregroundPressedFromElement: anElement [

	^ anElement toTheme colorError darker
]

{ #category : #accessing }
ToButtonImageDangerLook >> hoverStateEvent: anEvent [

	super hoverStateEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := self foregroundHoverFromElement: e.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #accessing }
ToButtonImageDangerLook >> initialStateEvent: anEvent [

	super initialStateEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := self foregroundInitialFromElement: e.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #accessing }
ToButtonImageDangerLook >> installStateEvent: anEvent [

	super installStateEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := self foregroundInitialFromElement: e.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #accessing }
ToButtonImageDangerLook >> pressedStateEvent: anEvent [

	super pressedStateEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := self foregroundPressedFromElement: e.
		self adaptForegroundIn: e withColor: c ]
]
