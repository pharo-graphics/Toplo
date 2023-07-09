Class {
	#name : #ToButtonPrimaryLook,
	#superclass : #ToButtonMainLook,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #testing }
ToButtonPrimaryLook >> hasBackground [

	^ true
]

{ #category : #'event handling' }
ToButtonPrimaryLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent ifBackgoundUpdated: [ 
			e background: e toTheme colorPrimary ] ]
]

{ #category : #'event handling' }
ToButtonPrimaryLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent ifBackgoundUpdated: [ 
			e background: e toTheme colorPrimaryHover ] ]
]

{ #category : #'event handling' }
ToButtonPrimaryLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent ifBackgoundUpdated: [ 
			e background: e toTheme colorPrimaryPressed ] ]
]
