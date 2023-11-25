Class {
	#name : 'ToGeneralButtonSkin',
	#superclass : 'ToRawSkin',
	#category : 'Toplo-Widget-Button-Core',
	#package : 'Toplo-Widget-Button',
	#tag : 'Core'
}

{ #category : 'stamp values' }
ToGeneralButtonSkin >> defaultBackground [

	^ Color transparent 
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor default.
		e border: (BlBorder paint: (e tokenValue: #'color-border-disabled') width: (e tokenValue: #'line-width')).
		e background: (e tokenValue: #'color-bg-container-disabled') ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder paint: (e tokenValue: #'color-border') width: (e tokenValue: #'line-width')).
		e background: (e tokenValue: #'color-bg-container') ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor hand.
		e border: (BlBorder paint: (e tokenValue: #'color-primary-hover') width: (e tokenValue: #'line-width')).
		e background: e hoveredBackground ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor default.
		e background: (e tokenValue: #'color-bg-container').
		e border: (BlBorder paint: (e tokenValue: #'color-border') width: (e tokenValue: #'line-width')). ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor default]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder paint: (e tokenValue: #'color-border') width: (e tokenValue: #'line-width')).
		e background: (e tokenValue: #'color-bg-container') ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder paint: (e tokenValue: #'color-primary-pressed') width: (e tokenValue: #'line-width')).
		e background: e pressedBackground ]
]
