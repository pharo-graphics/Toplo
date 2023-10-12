Class {
	#name : #ToGeneralButtonSkin,
	#superclass : #ToRawSkin,
	#instVars : [
		'pressed'
	],
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'event handling' }
ToGeneralButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	pressed ifTrue: [ ^ self ].
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor hand.
		e border: e hoveredBorder.
		e background: e hoveredBackground ]
]

{ #category : #'event handling' }
ToGeneralButtonSkin >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor default.
		e border: e defaultBorder.
		e background: e defaultBackground ]
]

{ #category : #'event handling' }
ToGeneralButtonSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	pressed := false.

]

{ #category : #'event handling' }
ToGeneralButtonSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	pressed := true.
	anEvent elementDo: [ :e |
		e border: e pressedBorder.
		e background: e pressedBackground ]
]

{ #category : #'event handling' }
ToGeneralButtonSkin >> releasedLookEvent: anEvent [

	super releasedLookEvent: anEvent.
	pressed := false.
	anEvent elementDo: [ :e |
		e border: e defaultBorder.
		e background: e defaultBackground ]
]
