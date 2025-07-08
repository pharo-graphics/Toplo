Class {
	#name : #ToSegmentedRadioButtonSkin,
	#superclass : #ToSegmentedCheckboxSkin,
	#category : #'Toplo-Widget-Segmented-Button'
}

{ #category : #'event handling' }
ToSegmentedRadioButtonSkin >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon
			innerImage: (e valueOfTokenNamed: #'radio-checked-image');
			innerImageColor: (e valueOfTokenNamed: #'color-primary') ]
]

{ #category : #accessing }
ToSegmentedRadioButtonSkin >> iconGeometryIn: aCheckbox [

	^ BlCircleGeometry new
]

{ #category : #'event handling' }
ToSegmentedRadioButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon:
			(ToImage inner: (e valueOfTokenNamed: #'radio-unchecked-image')).
		e icon extent: 20 asPoint ]
]

{ #category : #'event handling' }
ToSegmentedRadioButtonSkin >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon
			innerImage: (e valueOfTokenNamed: #'radio-unchecked-image');
			innerImageColor: (e valueOfTokenNamed: #'color-primary') ]
]
