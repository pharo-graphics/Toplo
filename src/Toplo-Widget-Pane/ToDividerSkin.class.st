Class {
	#name : #ToDividerSkin,
	#superclass : #ToRawSkin,
	#category : 'Toplo-Widget-Pane'
}

{ #category : #'event handling' }
ToDividerSkin >> dragStartedLookEvent: anEvent [

	super dragStartedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: e resizerCursor ]
]

{ #category : #'event handling' }
ToDividerSkin >> draggedLookEvent: anEvent [

	super draggedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: e resizerCursor.
		e border: e hoveredBorder.
		e background: e draggedBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: e resizerCursor.
		e border: e hoveredBorder.
		e background: e hoveredBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: e defaultBorder.
		e background: e defaultBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: e defaultBorder.
		e background: e defaultBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: e resizerCursor.
		e border: e pressedBorder.
		e background: e pressedBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> releasedLookEvent: anEvent [

	super releasedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor default.
		e border: e defaultBorder.
		e background: e defaultBackground ]
]
