Class {
	#name : #ToCheckboxSkin,
	#superclass : #ToGeneralButtonSkin,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'event handling' }
ToCheckboxSkin >> checkedLookEvent: anEvent [

	super checkedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: e imageCheckedBorder.
		e indeterminateChild background: Color transparent ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: e disabledBorder ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e | e icon border: e iconHoveredBorder ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> indeterminateLookEvent: anEvent [

	super indeterminateLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: e imageIndeterminateBorder.
		e indeterminateChild background: e defaultImageColor]
]

{ #category : #'event handling' }
ToCheckboxSkin >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e | e icon border: e iconDefaultBorder ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		| color |
		color := e isDisabled
			         ifTrue: [ e disabledBorder ]
			         ifFalse: [
				         e isChecked
					         ifTrue: [ e imageCheckedBorder ]
					         ifFalse: [ e imageUncheckedBorder ] ].
		e icon innerImage border: color.
		e isIndeterminate ifTrue: [
			e indeterminateChild background: e defaultImageColor ] ]
]

{ #category : #'event handling' }
ToCheckboxSkin >> uncheckedLookEvent: anEvent [

	super uncheckedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: e imageUncheckedBorder.
		e indeterminateChild background: Color transparent ]
]
