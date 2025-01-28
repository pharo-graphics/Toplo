Class {
	#name : #ToSegmentedCheckboxSkin,
	#superclass : #ToSegmentedToggleButtonSkin,
	#category : #'Toplo-Widget-Segmented-Button'
}

{ #category : #'event handling' }
ToSegmentedCheckboxSkin >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-primary-checked')
				 width: 5).
		e indeterminateBar background: Color transparent ]
]

{ #category : #'event handling' }
ToSegmentedCheckboxSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty.
		e background: Color transparent.
		e icon innerImage border:
			(e valueOfTokenNamed: #'color-border-disabled').
		e icon border: (e valueOfTokenNamed: #'color-border-disabled').
		e indeterminateBar background: Color transparent ]
]

{ #category : #'event handling' }
ToSegmentedCheckboxSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty.
		e background: BlBackground transparent.
		e icon border: (e valueOfTokenNamed: #'color-border') ]
]

{ #category : #'event handling' }
ToSegmentedCheckboxSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent enabledElementDo: [ :e | 
			e border: BlBorder empty.
			e icon border: (BlBorder paint: (e valueOfTokenNamed: #'color-primary') width: 1) ]
]

{ #category : #accessing }
ToSegmentedCheckboxSkin >> iconGeometryIn: aCheckbox [

	^ BlRoundedRectangleGeometry cornerRadius: 4
]

{ #category : #'event handling' }
ToSegmentedCheckboxSkin >> indeterminateSkinEvent: anEvent [

	super indeterminateSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: (BlBorder paint: (e valueOfTokenNamed: #'color-primary') width: 0).
		e indeterminateBar background: (e valueOfTokenNamed: #'color-primary')]
]

{ #category : #'event handling' }
ToSegmentedCheckboxSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e preventSelectionSkinEvents.
		e border: BlBorder empty.
		e iconImage: (e valueOfTokenNamed: #'checkbox-image-builder') value.
		e icon geometry: (self iconGeometryIn: e).
		e icon border: (e valueOfTokenNamed: #'color-border').
		e startInterspace: (e valueOfTokenNamed: #'button-interspace') ]
]

{ #category : #'event handling' }
ToSegmentedCheckboxSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent enabledElementDo: [ :e |
		e border: BlBorder empty.
		e icon border: (e valueOfTokenNamed: #'color-border') ]
]

{ #category : #'event handling' }
ToSegmentedCheckboxSkin >> pressedSkinEvent: anEvent [

	super pressedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToSegmentedCheckboxSkin >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty.
		e icon innerImage border:
			(BlBorder paint: (e valueOfTokenNamed: #'color-primary') width: 0).
		e indeterminateBar background: Color transparent ]
]
