Class {
	#name : #ToSegmentedCheckboxSkin,
	#superclass : #ToSegmentedToggleButtonSkin,
	#category : #'Toplo-Widget-Segmented-Button'
}

{ #category : #'event handling' }
ToSegmentedCheckboxSkin >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon
			innerImage: (e valueOfTokenNamed: #'checkbox-checked-image');
			innerImageColor: (e valueOfTokenNamed: #'color-primary') ]
]

{ #category : #'event handling' }
ToSegmentedCheckboxSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty.
		e background: Color transparent.
		e iconDo: [ :ic |
			ic innerImageColor: (e valueOfTokenNamed: #'color-text-disabled') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text-disabled') ] ]
]

{ #category : #'event handling' }
ToSegmentedCheckboxSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty.
		e background: BlBackground transparent.
		e icon innerImageColor: (e valueOfTokenNamed: #'color-primary') ]
]

{ #category : #'event handling' }
ToSegmentedCheckboxSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
			e border: BlBorder empty ]
]

{ #category : #accessing }
ToSegmentedCheckboxSkin >> iconGeometryIn: aCheckbox [

	^ BlRoundedRectangleGeometry cornerRadius: 4
]

{ #category : #'event handling' }
ToSegmentedCheckboxSkin >> indeterminateSkinEvent: anEvent [

	super indeterminateSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon
			innerImage: (e valueOfTokenNamed: 'checkbox-indeterminate-image');
			innerImageColor: (e valueOfTokenNamed: #'color-primary')]
]

{ #category : #'event handling' }
ToSegmentedCheckboxSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e preventSelectionSkinEvents.
		e icon:
			(ToImage inner: (e valueOfTokenNamed: #'checkbox-unchecked-image')).
		e hasLabel
			ifTrue: [
			e startInterspace: (e valueOfTokenNamed: #'button-interspace') ]
			ifFalse: [ e startInterspace: 0 ].
		(e hasEndElement and: [ e hasLabel ])
			ifTrue: [
			e endInterspace: (e valueOfTokenNamed: #'button-interspace') ]
			ifFalse: [ e endInterspace: 0 ].
		e icon size: (e valueOfTokenNamed: #'checkable-icon-size').
		e icon innerImageColor: (e valueOfTokenNamed: #'color-primary').
		e icon geometry: (self iconGeometryIn: e).
		e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToSegmentedCheckboxSkin >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
					ic innerImageColor: (e valueOfTokenNamed: #'color-primary') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text') ].
		e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToSegmentedCheckboxSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e iconDo: [ :ic |
					ic innerImageColor: (e valueOfTokenNamed: #'color-primary') ].
		e labelDo: [ :lab |
			lab foreground: (e valueOfTokenNamed: #'color-text') ].
		e border: BlBorder empty ]
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
		e icon
			innerImage: (e valueOfTokenNamed: #'checkbox-unchecked-image');
			innerImageColor: (e valueOfTokenNamed: #'color-primary') ]
]
