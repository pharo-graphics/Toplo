Class {
	#name : 'ToSwitchButtonSkin',
	#superclass : 'ToRawSkin',
	#category : 'Toplo-Widget-Button-Switch',
	#package : 'Toplo-Widget-Button',
	#tag : 'Switch'
}

{ #category : 'event handling' }
ToSwitchButtonSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor default.
		e background: (e tokenValueNamed: #'color-bg-container-disabled') ]
]

{ #category : 'event handling' }
ToSwitchButtonSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: Color transparent ]
]

{ #category : 'event handling' }
ToSwitchButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor hand]
]

{ #category : 'event handling' }
ToSwitchButtonSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e vFitContent.
		e mouseCursor: BlCursor default.
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e tokenValueNamed: 'border-radius')).
		e border: BlBorder empty.
		e padding: (BlInsets
				 top: (e tokenValueNamed: #'padding-content-V')
				 left: (e tokenValueNamed: #'padding-content-H')
				 bottom: (e tokenValueNamed: #'padding-content-V')
				 right: (e tokenValueNamed: #'padding-content-H')) ]
]

{ #category : 'event handling' }
ToSwitchButtonSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor default ]
]

{ #category : 'event handling' }
ToSwitchButtonSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e | ]
]
