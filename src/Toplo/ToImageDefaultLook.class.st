Class {
	#name : #ToImageDefaultLook,
	#superclass : #ToImageLook,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #accessing }
ToImageDefaultLook >> foregroundHoverFromElement: anElement [

	^ self foregroundInitialFromElement: anElement
]

{ #category : #accessing }
ToImageDefaultLook >> foregroundInitialFromElement: anElement [

	^ anElement toTheme colorImage
]

{ #category : #accessing }
ToImageDefaultLook >> foregroundPressedFromElement: anElement [

	^ self foregroundInitialFromElement: anElement
]

{ #category : #'event handling' }
ToImageDefaultLook >> hoverStateEvent: anEvent [


]

{ #category : #'event handling' }
ToImageDefaultLook >> initialStateEvent: anEvent [

	anEvent elementDo: [ :e |
		| c |
		c := self foregroundInitialFromElement: e.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToImageDefaultLook >> installStateEvent: anEvent [

	super installStateEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := self foregroundInitialFromElement: e.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToImageDefaultLook >> pressedStateEvent: anEvent [


]
