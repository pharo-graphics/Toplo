Class {
	#name : #ToCheckboxSkin,
	#superclass : #ToButtonSkin,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'event handling' }
ToCheckboxSkin >> checkedLookEvent: anEvent [

	super checkedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: (BlBorder paint: (e valueOfTokenNamed: #'color-primary-checked') width: 6).
		e indeterminateBar background: Color transparent ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: Color transparent.
		e border: BlBorder empty.		
		e icon innerImage border: (e valueOfTokenNamed: #'color-border-disabled').
		e icon border: (e valueOfTokenNamed: #'color-border-disabled').
		e indeterminateBar background: Color transparent ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder empty).
		e background: (e valueOfTokenNamed: #'color-bg-container').
		e icon border: (e valueOfTokenNamed: #'color-border') ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e border: (BlBorder empty).		
		e icon border: (BlBorder paint: (e valueOfTokenNamed: #'color-primary') width: 1) ]
]

{ #category : #accessing }
ToCheckboxSkin >> iconGeometryIn: aCheckbox [

	^ BlRoundedRectangleGeometry cornerRadius: 4
]

{ #category : #'event handling' }
ToCheckboxSkin >> indeterminateLookEvent: anEvent [

	super indeterminateLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: (BlBorder paint: (e valueOfTokenNamed: #'color-primary') width: 0).
		e indeterminateBar background: (e valueOfTokenNamed: #'color-primary')]
]

{ #category : #'event handling' }
ToCheckboxSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e startInterspace: 10.
		e iconImage: ((e valueOfTokenNamed: #'checkbox-image-builder') value).
		e icon geometry: (self iconGeometryIn: e).
		e border: Color black. (e valueOfTokenNamed: #'color-border-checkable').		
		e icon border: (e valueOfTokenNamed: #'color-border').
		e padding: (BlInsets
				 top: (e valueOfTokenNamed: #'padding-content-V')
				 left: (e valueOfTokenNamed: #'padding-XS')
				 bottom: (e valueOfTokenNamed: #'padding-content-V')
				 right: (e valueOfTokenNamed: #'padding-XS')) ]
	
]

{ #category : #'event handling' }
ToCheckboxSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e border: (BlBorder empty).		
		e icon border: (e valueOfTokenNamed: #'color-border') ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> uncheckedLookEvent: anEvent [

	super uncheckedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: (BlBorder paint: (e valueOfTokenNamed: #'color-primary') width: 0).
		e indeterminateBar background: Color transparent ]
]
