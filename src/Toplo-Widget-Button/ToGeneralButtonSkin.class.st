Class {
	#name : 'ToGeneralButtonSkin',
	#superclass : 'ToRawSkin',
	#category : 'Toplo-Widget-Button-Core',
	#package : 'Toplo-Widget-Button',
	#tag : 'Core'
}

{ #category : 'event handling' }
ToGeneralButtonSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor default.
		e border: (BlBorder paint: (e toValueOf: #'color-border-disabled') width: (e toValueOf: #'line-width')).
		e background: (e toValueOf: #'color-bg-container-disabled') ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder paint: (e toValueOf: #'color-border') width: (e toValueOf: #'line-width')).
		e background: (e toValueOf: #'color-bg-container') ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor hand.
		e border: (BlBorder paint: (e toValueOf: #'color-primary-hover') width: (e toValueOf: #'line-width')) ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e vFitContent.
		e mouseCursor: BlCursor default.
		e background: (e toValueOf: #'color-bg-container').
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e toValueOf: 'border-radius')).
		e border: (BlBorder
				 paint: (e toValueOf: #'color-border')
				 width: (e toValueOf: #'line-width')).
		e padding: (BlInsets
				 top: (e toValueOf: #'padding-content-V')
				 left: (e toValueOf: #'padding-content-H')
				 bottom: (e toValueOf: #'padding-content-V')
				 right: (e toValueOf: #'padding-content-H')) ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder paint: (e toValueOf: #'color-border') width: (e toValueOf: #'line-width')).
		e background: (e toValueOf: #'color-bg-container') ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder paint: (e toValueOf: #'color-primary-pressed') width: (e toValueOf: #'line-width')) ]
]
