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
		e border: (BlBorder paint: (e tokenValueNamed: #'color-border-disabled') width: (e tokenValueNamed: #'line-width')).
		e background: (e tokenValueNamed: #'color-bg-container-disabled') ]
]

{ #category : #'event handling' }
ToGeneralButtonMenuItemSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder paint: (Color transparent) width: (e tokenValueNamed: #'line-width')).
		e background: (e tokenValueNamed: #'color-bg-container') ]
]

{ #category : #'event handling' }
ToGeneralButtonMenuItemSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor webLink.
		e border: (BlBorder paint: (e tokenValueNamed: #'color-primary-hover') width: (e tokenValueNamed: #'line-width')) ]
]

{ #category : #'event handling' }
ToGeneralButtonMenuItemSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e vFitContent.
		e mouseCursor: Cursor normal.
		e background: (e tokenValueNamed: #'color-bg-container').
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e tokenValueNamed: 'border-radius')).
		e padding: (BlInsets
				 top: (e tokenValueNamed: #'padding-content-V')
				 left: (e tokenValueNamed: #'padding-XS')
				 bottom: (e tokenValueNamed: #'padding-content-V')
				 right: (e tokenValueNamed: #'padding-XS')) ]
]

{ #category : #'event handling' }
ToGeneralButtonMenuItemSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder paint: (Color transparent) width: (e tokenValueNamed: #'line-width')).
		e background: (e tokenValueNamed: #'color-bg-container') ]
]

{ #category : #'event handling' }
ToGeneralButtonMenuItemSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder paint: (e tokenValueNamed: #'color-primary-pressed') width: (e tokenValueNamed: #'line-width')) ]
]
