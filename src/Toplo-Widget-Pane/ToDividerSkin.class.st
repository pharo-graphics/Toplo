Class {
	#name : #ToDividerSkin,
	#superclass : #ToRawSkin,
	#instVars : [
		'pressed'
	],
	#category : #'Toplo-Widget-Pane'
}

{ #category : #'event handling' }
ToDividerSkin >> hoveredLookEvent: anEvent [

	pressed ifTrue: [ ^ self ].
	anEvent elementDo: [ :e |
		e mouseCursor: e resizerCursor.
		e border: e hoveredBorder.
		e background: e hoveredBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> initialLookEvent: anEvent [

	anEvent sourceEvent ifNotNil: [ :evt |
		evt anyButtonPressed ifTrue: [ ^ self ] ].
	pressed ifTrue: [ ^ self ].
	anEvent elementDo: [ :e |
		e border: e defaultBorder.
		e background: e defaultBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> installLookEvent: anEvent [

	pressed := false.
	anEvent elementDo: [ :e |
		e thickness: e defaultThickness.
		e geometry: e defaultGeometry.
		e margin: e defaultMargins.
		e padding: e defaultPadding ]
]

{ #category : #'event handling' }
ToDividerSkin >> pressedLookEvent: anEvent [

	pressed := true.
	anEvent elementDo: [ :e |
		e border: e pressedBorder.
		e background: e pressedBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> releasedLookEvent: anEvent [

	pressed := false.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor default.
		e border: e defaultBorder.
		e background: e defaultBackground ]
]
