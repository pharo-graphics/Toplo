Class {
	#name : #ToRadioMenuItemSkin,
	#superclass : #ToCheckMenuItemSkin,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #accessing }
ToRadioMenuItemSkin >> iconGeometryIn: aCheckbox [

	^ BlCircleGeometry new
]

{ #category : #'event handling' }
ToRadioMenuItemSkin >> imageFor: aCheckable [

	^ aCheckable isChecked
		  ifTrue: [ aCheckable valueOfTokenNamed: #'radio-checked-image' ]
		  ifFalse: [
		  aCheckable valueOfTokenNamed: #'radio-unchecked-image' ]
]

{ #category : #'event handling' }
ToRadioMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e icon:
				(ToImage inner: (e valueOfTokenNamed: #'radio-unchecked-image')).
			e icon extent: (e valueOfTokenNamed: #'menu-icon-size') ]
]
