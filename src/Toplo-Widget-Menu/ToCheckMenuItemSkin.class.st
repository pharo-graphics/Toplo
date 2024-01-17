Class {
	#name : #ToCheckMenuItemSkin,
	#superclass : #ToMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'event handling' }
ToCheckMenuItemSkin >> checkedLookEvent: anEvent [

	super checkedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: (BlBorder paint: (e tokenValueNamed: #'color-primary') width: 6).
		e indeterminateChild background: Color transparent ]
]

{ #category : #'event handling' }
ToCheckMenuItemSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: Color transparent.
		e border: BlBorder empty.		
		e icon innerImage border: (e tokenValueNamed: #'color-border-disabled').
		e icon border: (e tokenValueNamed: #'color-border-disabled').
		e indeterminateChild background: Color transparent ]
]

{ #category : #'event handling' }
ToCheckMenuItemSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder empty).
		e background: e defaultBackground.
		e icon border: (e tokenValueNamed: #'color-border') ]
]

{ #category : #'event handling' }
ToCheckMenuItemSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e border: (BlBorder empty).		
		e mouseCursor: Cursor webLink.
		e icon border: (BlBorder paint: (e tokenValueNamed: #'color-primary') width: 1) ]
]

{ #category : #accessing }
ToCheckMenuItemSkin >> iconGeometryIn: aCheckbox [

	^ BlRoundedRectangleGeometry cornerRadius: 4
]

{ #category : #'event handling' }
ToCheckMenuItemSkin >> indeterminateLookEvent: anEvent [

	super indeterminateLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: (BlBorder paint: (e tokenValueNamed: #'color-primary') width: 0).
		e indeterminateChild background: (e tokenValueNamed: #'color-primary')]
]

{ #category : #'event handling' }
ToCheckMenuItemSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e iconImage: ((e tokenValueNamed: #'checkbox-image-builder') value).
		e icon geometry: (self iconGeometryIn: e).
		e border: (e tokenValueNamed: #'color-border-checkable').		
		e icon border: (e tokenValueNamed: #'color-border') ]
	
]

{ #category : #'event handling' }
ToCheckMenuItemSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e border: (BlBorder empty).		
		e icon border: (e tokenValueNamed: #'color-border') ]
]

{ #category : #'event handling' }
ToCheckMenuItemSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToCheckMenuItemSkin >> uncheckedLookEvent: anEvent [

	super uncheckedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: (BlBorder paint: (e tokenValueNamed: #'color-primary') width: 0).
		e indeterminateChild background: Color transparent ]
]
