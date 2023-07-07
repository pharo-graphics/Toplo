Class {
	#name : #ToButtonTextDangerLook,
	#superclass : #ToButtonLookDecorator,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'event handling' }
ToButtonTextDangerLook >> hoverLookEvent: anEvent [

	super hoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent ifBackgoundUpdated: [ 
			e background: e toTheme colorErrorBg ] ]
]

{ #category : #'event handling' }
ToButtonTextDangerLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		anEvent ifBackgoundUpdated: [ 
			e background: e toTheme colorErrorBg ] ]
]
