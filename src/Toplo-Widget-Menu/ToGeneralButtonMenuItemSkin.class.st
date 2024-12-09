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
		e mouseCursor: Cursor normal.
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius')).
		e isRootMenuItem
			ifTrue: [
				e padding: (BlInsets
						 horizontal: (e valueOfTokenNamed: #'padding-content-H')
						 vertical: (e valueOfTokenNamed: #'padding-content-VXS')) ]
			ifFalse: [
				e padding: (BlInsets
						 horizontal: (e valueOfTokenNamed: #'padding-content-HS')
						 vertical: (e valueOfTokenNamed: #'padding-content-VXS')) ] ]
]

{ #category : #'event handling' }
ToGeneralButtonMenuItemSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]
