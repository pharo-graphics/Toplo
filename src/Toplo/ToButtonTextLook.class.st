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
ToButtonTextLook >> hoverLookEvent: anEvent [

	super hoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent ifBackgoundUpdated: [ 
			e background: e toTheme colorBgTextHover ] ]
]

{ #category : #'event handling' }
ToButtonTextLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent ifBackgoundUpdated: [ 
			e background: Color transparent ] ]
]

{ #category : #'event handling' }
ToButtonTextLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent ifBackgoundUpdated: [ 
			e background: e toTheme colorBgTextActive ] ]
]
