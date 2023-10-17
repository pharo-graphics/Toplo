Class {
	#name : 'ToGeneralButtonSkin',
	#superclass : 'ToRawSkin',
	#category : 'Toplo-Widget-Button-Core',
	#package : 'Toplo-Widget-Button',
	#tag : 'Core'
}

{ #category : 'event handling' }
ToGeneralButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor hand.
		e border: e hoveredBorder.
		e background: e hoveredBackground ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor default.
		e border: e defaultBorder.
		e background: e defaultBackground ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: e pressedBorder.
		e background: e pressedBackground ]
]

{ #category : 'event handling' }
ToGeneralButtonSkin >> releasedLookEvent: anEvent [

	super releasedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: e defaultBorder.
		e background: e defaultBackground ]
]
