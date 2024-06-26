Class {
	#name : #ToDividerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Pane'
}

{ #category : #'event handling' }
ToDividerSkin >> dragStartedSkinEvent: anEvent [

	super dragStartedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: e resizerCursor ]
]

{ #category : #'event handling' }
ToDividerSkin >> draggedSkinEvent: anEvent [

	super draggedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: e resizerCursor.
		e border: e hoveredBorder.
		e background: e draggedBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: e resizerCursor.
		e border: e hoveredBorder.
		e background: e hoveredBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: e defaultBorder.
		e background: e defaultBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
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
		e mouseCursor: Cursor normal.
		e border: e defaultBorder.
		e background: e defaultBackground ]
]
