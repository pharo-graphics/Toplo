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
<<<<<<< HEAD
			e icon:
				(ToIcon innerImage:
					 (e valueOfTokenNamed: #'radio-unchecked-image')).
			e icon size: 20 asPoint ]
=======
		e icon:
			(ToImage inner: (e valueOfTokenNamed: #'radio-unchecked-image')).
		e icon size: (e valueOfTokenNamed: #'checkable-icon-size') ]
>>>>>>> parent of e3811d59 (Merge branch 'ToIconAdding' into dev)
]

{ #category : #'event handling' }
ToRadioButtonSkin >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon
			innerImage: (e valueOfTokenNamed: #'radio-unchecked-image');
			innerImageColor: (e valueOfTokenNamed: #'color-primary') ]
]
