Class {
	#name : #ToGeneralButtonSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'event handling' }
ToGeneralButtonSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-border-disabled')
				 width: (e valueOfTokenNamed: #'line-width')).
		e background: (e valueOfTokenNamed: #'color-bg-container-disabled') ]
]

{ #category : #'event handling' }
ToGeneralButtonSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-border')
				 width: (e valueOfTokenNamed: #'line-width')).
		(e hasStamp: #iconic) ifFalse: [
			e background: (e valueOfTokenNamed: #'color-bg-container') ] ]
]

{ #category : #'event handling' }
ToGeneralButtonSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor webLink.
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-primary-hover')
				 width: (e valueOfTokenNamed: #'line-width')) ]
]

{ #category : #'event handling' }
ToGeneralButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		(e hasStamp: #circle)
			ifTrue: [ e geometry: BlCircleGeometry new ]
			ifFalse: [
				e geometry: (BlRoundedRectangleGeometry cornerRadius:
						 (e valueOfTokenNamed: 'border-radius')) ].
		(e hasStamp: #iconic)
			ifFalse: [
				e padding: (BlInsets
						 top: (e valueOfTokenNamed: #'padding-content-V')
						 left: (e valueOfTokenNamed: #'padding-XS')
						 bottom: (e valueOfTokenNamed: #'padding-content-V')
						 right: (e valueOfTokenNamed: #'padding-XS')) ] ]
]

{ #category : #'event handling' }
ToGeneralButtonSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-border')
				 width: (e valueOfTokenNamed: #'line-width')) ]
]

{ #category : #'event handling' }
ToGeneralButtonSkin >> pressedSkinEvent: anEvent [

	super pressedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-primary-pressed')
				 width: (e valueOfTokenNamed: #'line-width')) ]
]
