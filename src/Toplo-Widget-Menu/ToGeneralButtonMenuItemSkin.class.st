Class {
	#name : #ToGeneralButtonMenuItemSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToGeneralButtonMenuItemSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]

{ #category : #'event handling' }
ToGeneralButtonMenuItemSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor webLink ]
]

{ #category : #'event handling' }
ToGeneralButtonMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e vFitContent.
		e mouseCursor: Cursor normal.
		e border: BlBorder empty.
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius')) ]
]

{ #category : #'event handling' }
ToGeneralButtonMenuItemSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]
