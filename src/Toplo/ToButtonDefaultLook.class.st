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
ToButtonDefaultLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: ((self decoratedBorderBuilderFromElement: e)
				 paint: e toTheme colorPrimaryHover;
				 build) ]
]

{ #category : #'event handling' }
ToButtonDefaultLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border:
			((self decoratedBorderBuilderFromElement: e) paint:
				 e toTheme colorPrimaryPressed) build ]
]
