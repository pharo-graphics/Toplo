Class {
	#name : #ToButtonDefaultLook,
	#superclass : #ToButtonLook,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #'event handling' }
ToButtonDefaultLook >> elementAddedToSceneGraphEvent: anEvent [

	super elementAddedToSceneGraphEvent: anEvent.
	self initialStateEvent: (ToInitialStateEvent new copyFrom: anEvent)
]

{ #category : #'event handling' }
ToButtonDefaultLook >> hoverStateEvent: anEvent [

	anEvent elementDo: [ :e |
		e border:
			((self borderBuilderFromElement: e) paint:
				 e toTheme colorPrimaryHover) build ].

	super hoverStateEvent: anEvent
]

{ #category : #'event handling' }
ToButtonDefaultLook >> initialStateEvent: anEvent [

	anEvent elementDo: [ :e |
		e border: (self borderBuilderFromElement: e) build.
		e background: e toTheme colorBgContainer.
		e height: e toTheme controlHeight.
		e geometry: (BlRoundedRectangleGeometry cornerRadius: e toTheme borderRadius).
		e padding: (BlInsets
				 top: e toTheme paddingXS / 2
				 left: e toTheme paddingContentHorizontal
				 bottom: e toTheme paddingXS / 2
				 right: e toTheme paddingContentHorizontal).
		e effect: (BlGaussianShadowEffect
				 color: (e toTheme colorBorder
					  alphaMixed: 0.233
					  with: e toTheme backgroundColor)
				 width: 2
				 offset: 0 @ 2)].
	
	super initialStateEvent: anEvent
]

{ #category : #'event handling' }
ToButtonDefaultLook >> pressedStateEvent: anEvent [

	anEvent elementDo: [ :e |
		e border:
			((self borderBuilderFromElement: e) paint:
				 e toTheme colorPrimaryPressed) build ].
	super pressedStateEvent: anEvent
]
