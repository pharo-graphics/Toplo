Class {
	#name : #ToRadioButtonSkin,
	#superclass : #ToCheckboxSkin,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #accessing }
ToRadioButtonSkin >> iconGeometryIn: aCheckbox [

	^ BlCircleGeometry new
]

{ #category : #'event handling' }
ToRadioButtonSkin >> imageFor: aCheckable [

	^ aCheckable isChecked
		  ifTrue: [ aCheckable valueOfTokenNamed: #'radio-checked-image' ]
		  ifFalse: [
		  aCheckable valueOfTokenNamed: #'radio-unchecked-image' ]
]

{ #category : #'event handling' }
ToRadioButtonSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e icon:
				(ToImage inner: (e valueOfTokenNamed: #'radio-unchecked-image')).
			e icon extent: (e valueOfTokenNamed: #'checkable-icon-size') ]
]
