Class {
	#name : #ToMenuItemElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'event handling' }
ToMenuItemElementSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]

{ #category : #'event handling' }
ToMenuItemElementSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor webLink ]
]

{ #category : #'event handling' }
ToMenuItemElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius')).
		e isRootMenuItem
			ifTrue: [
				e padding: (BlInsets
						 horizontal: (e valueOfTokenNamed: #'padding-content-H')
						 vertical: (e valueOfTokenNamed: #'padding-content-VS')) ]
			ifFalse: [
				e padding:
					(BlInsets horizontal: (e valueOfTokenNamed: #'padding-content-VS')) ] ]
]

{ #category : #'event handling' }
ToMenuItemElementSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal ]
]
