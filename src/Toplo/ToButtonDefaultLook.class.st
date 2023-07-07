Class {
	#name : #ToButtonDefaultLook,
	#superclass : #ToButtonMainLook,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #testing }
ToButtonDefaultLook >> hasBackground [

	^ false
]

{ #category : #'event handling' }
ToButtonDefaultLook >> hoverLookEvent: anEvent [

	super hoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: ((self decoratedBorderBuilderFromElement: e)
				 paint: e toTheme colorPrimaryHover;
				 build) ]
]

{ #category : #'event handling' }
ToButtonDefaultLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: ((self decoratedBorderBuilderFromElement: e)
				 paint: e toTheme colorBorder;
				 build).
		anEvent ifBackgoundUpdated: [
			e background: e toTheme colorBgContainer ] ]
]

{ #category : #'event handling' }
ToButtonDefaultLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border:
			((self decoratedBorderBuilderFromElement: e) paint:
				 e toTheme colorPrimaryPressed) build ]
]
