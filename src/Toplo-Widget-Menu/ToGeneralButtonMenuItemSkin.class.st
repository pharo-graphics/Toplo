Class {
	#name : #ToGeneralButtonMenuItemSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToGeneralButtonMenuItemSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e border: (BlBorder paint: (e valueOfTokenNamed: #'color-border-disabled') width: (e valueOfTokenNamed: #'line-width')).
		e background: (e valueOfTokenNamed: #'color-bg-container-disabled') ]
]

{ #category : #'event handling' }
ToGeneralButtonMenuItemSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder paint: (Color transparent) width: (e valueOfTokenNamed: #'line-width')).
		e background: (e valueOfTokenNamed: #'color-bg-container') ]
]

{ #category : #'event handling' }
ToGeneralButtonMenuItemSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor webLink.
		e border: (BlBorder paint: (e valueOfTokenNamed: #'color-primary-hover') width: (e valueOfTokenNamed: #'line-width')) ]
]

{ #category : #'event handling' }
ToGeneralButtonMenuItemSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e vFitContent.
		e mouseCursor: Cursor normal.
		e background: (e valueOfTokenNamed: #'color-bg-container').
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius')).
		e padding: (BlInsets
				 top: (e valueOfTokenNamed: #'padding-content-V')
				 left: (e valueOfTokenNamed: #'padding-XS')
				 bottom: (e valueOfTokenNamed: #'padding-content-V')
				 right: (e valueOfTokenNamed: #'padding-XS')) ]
]

{ #category : #'event handling' }
ToGeneralButtonMenuItemSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder paint: (Color transparent) width: (e valueOfTokenNamed: #'line-width')).
		e background: (e valueOfTokenNamed: #'color-bg-container') ]
]

{ #category : #'event handling' }
ToGeneralButtonMenuItemSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder paint: (e valueOfTokenNamed: #'color-primary-pressed') width: (e valueOfTokenNamed: #'line-width')) ]
]
