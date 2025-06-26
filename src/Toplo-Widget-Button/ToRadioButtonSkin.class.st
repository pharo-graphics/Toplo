Class {
	#name : #ToRadioButtonSkin,
	#superclass : #ToCheckboxSkin,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'event handling' }
ToRadioButtonSkin >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon
			innerImage: (e valueOfTokenNamed: #'radio-checked-image');
			innerImageColor: (e valueOfTokenNamed: #'color-primary') ]
]

{ #category : #accessing }
ToRadioButtonSkin >> iconGeometryIn: aCheckbox [

	^ BlCircleGeometry new
]

{ #category : #'event handling' }
ToRadioButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e icon:
				(ToImage innerImage:
					 (e valueOfTokenNamed: #'radio-unchecked-image')).
			e icon size: 20 asPoint ]
]

{ #category : #'event handling' }
ToRadioButtonSkin >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon
			innerImage: (e valueOfTokenNamed: #'radio-unchecked-image');
			innerImageColor: (e valueOfTokenNamed: #'color-primary') ]
]
