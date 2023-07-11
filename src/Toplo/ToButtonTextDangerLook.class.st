Class {
	#name : #ToButtonTextDangerLook,
	#superclass : #ToButtonLookDecorator,
	#category : #'Toplo-Widget-Button-Look'
}

{ #category : #'event handling' }
ToButtonTextDangerLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
			e background: Color transparent ] 
]

{ #category : #'event handling' }
ToButtonTextDangerLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	anEvent elementDo: [ :e |
			e background: e toTheme colorErrorBg ] 
]

{ #category : #'event handling' }
ToButtonTextDangerLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
			e background: e toTheme colorErrorBg ]
]
