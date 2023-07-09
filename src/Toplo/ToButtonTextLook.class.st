Class {
	#name : #ToButtonTextLook,
	#superclass : #ToButtonMainLook,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #testing }
ToButtonTextLook >> hasBackground [

	^ true
]

{ #category : #'event handling' }
ToButtonTextLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent ifBackgoundUpdated: [ 
			e background: Color transparent ] ]
]

{ #category : #'event handling' }
ToButtonTextLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent ifBackgoundUpdated: [ 
			e background: e toTheme colorBgTextHover ] ]
]

{ #category : #'event handling' }
ToButtonTextLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent ifBackgoundUpdated: [ 
			e background: e toTheme colorBgTextActive ] ]
]
