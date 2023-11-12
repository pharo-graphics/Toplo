Class {
	#name : 'ToCheckboxSkin',
	#superclass : 'ToGeneralButtonSkin',
	#category : 'Toplo-Widget-Button-Checkable',
	#package : 'Toplo-Widget-Button',
	#tag : 'Checkable'
}

{ #category : 'event handling' }
ToCheckboxSkin >> checkedLookEvent: anEvent [

	super checkedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: e imageCheckedBorder.
		e indeterminateChild background: Color transparent ]
]

{ #category : 'event handling' }
ToCheckboxSkin >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: e disabledBackground.
		e icon innerImage border: e disabledBorder.
		e indeterminateChild background: Color transparent ]
]

{ #category : 'event handling' }
ToCheckboxSkin >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon border: e iconDefaultBorder.
		e isChecked ifTrue: [
			e icon innerImage border: e imageCheckedBorder.
			e indeterminateChild background: Color transparent ].
		e isIndeterminate ifTrue: [
			e icon innerImage border: e imageIndeterminateBorder.
			e indeterminateChild background: e defaultImageColor ] ]
]

{ #category : 'event handling' }
ToCheckboxSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e isDisabled ifTrue: [ ^ self ].
		e icon border: e iconHoveredBorder ]
]

{ #category : 'event handling' }
ToCheckboxSkin >> indeterminateLookEvent: anEvent [

	super indeterminateLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: e imageIndeterminateBorder.
		e indeterminateChild background: e defaultImageColor]
]

{ #category : 'event handling' }
ToCheckboxSkin >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	anEvent elementDo: [ :e | ] 
]

{ #category : 'event handling' }
ToCheckboxSkin >> installIconImageIn: aCheckbox [

	aCheckbox isIndeterminate ifTrue: [
		aCheckbox indeterminateChild background: aCheckbox defaultImageColor.
		^ aCheckbox icon innerImage border: aCheckbox imageIndeterminateBorder ].
	aCheckbox isChecked ifTrue: [
		^ aCheckbox icon innerImage border: aCheckbox imageCheckedBorder ].
	aCheckbox icon innerImage border: aCheckbox imageUncheckedBorder
]

{ #category : 'event handling' }
ToCheckboxSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | self installIconImageIn: e ]
]

{ #category : 'event handling' }
ToCheckboxSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e isDisabled ifTrue: [ ^ self ].
		e icon border: e iconDefaultBorder ]
]

{ #category : 'event handling' }
ToCheckboxSkin >> releasedLookEvent: anEvent [

	super releasedLookEvent: anEvent.
	anEvent elementDo: [ :e | "e icon border: e iconDefaultBorder" ]
]

{ #category : 'event handling' }
ToCheckboxSkin >> uncheckedLookEvent: anEvent [

	super uncheckedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e icon innerImage border: e imageUncheckedBorder.
		e indeterminateChild background: Color transparent ]
]
