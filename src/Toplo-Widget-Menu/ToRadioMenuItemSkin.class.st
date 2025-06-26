Class {
	#name : #ToRadioMenuItemSkin,
	#superclass : #ToCheckMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'event handling' }
ToRadioMenuItemSkin >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon
			innerImage: (e valueOfTokenNamed: #'radio-checked-image');
			innerImageColor: (e valueOfTokenNamed: #'color-primary') ]
]

{ #category : #accessing }
ToRadioMenuItemSkin >> iconGeometryIn: aCheckbox [

	^ BlCircleGeometry new
]

{ #category : #'event handling' }
ToRadioMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e icon:
				(ToIcon innerImage:
					 (e valueOfTokenNamed: #'radio-unchecked-image')).
			e icon size: 20 asPoint ]
]

{ #category : #'event handling' }
ToRadioMenuItemSkin >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon
			innerImage: (e valueOfTokenNamed: #'radio-unchecked-image');
			innerImageColor: (e valueOfTokenNamed: #'color-primary') ]
]
