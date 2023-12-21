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
		e border: (BlBorder
				 paint: (e tokenValueNamed: #'color-border-disabled')
				 width: (e tokenValueNamed: #'line-width')).
		e background: (e tokenValueNamed: #'color-bg-container-disabled') ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e tokenValueNamed: #'color-border')
				 width: (e tokenValueNamed: #'line-width')).
		e background: (e tokenValueNamed: #'color-bg-container') ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor hand.
		e border: (BlBorder
				 paint: (e tokenValueNamed: #'color-primary-hover')
				 width: (e tokenValueNamed: #'line-width')) ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor default.
		e background: (e tokenValueNamed: #'color-bg-container').
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e tokenValueNamed: 'border-radius')).
		e border: (BlBorder
				 paint: (e tokenValueNamed: #'color-border')
				 width: (e tokenValueNamed: #'line-width')).
		e padding: (BlInsets
				 top: (e tokenValueNamed: #'padding-content-V')
				 left: (e tokenValueNamed: #'padding-XS')
				 bottom: (e tokenValueNamed: #'padding-content-V')
				 right: (e tokenValueNamed: #'padding-XS')) ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e tokenValueNamed: #'color-border')
				 width: (e tokenValueNamed: #'line-width')).
		e background: (e tokenValueNamed: #'color-bg-container') ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e tokenValueNamed: #'color-primary-pressed')
				 width: (e tokenValueNamed: #'line-width')) ]
]
