Class {
	#name : #ToSelectableTextFieldSelectionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Album-TextField'
}

{ #category : #'event handling' }
ToSelectableTextFieldSelectionElementSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e valueOfTokenNamed: #'color-primary-selection-disabled').
		e background:
			(e valueOfTokenNamed: #'color-primary-selection-disabled') ]
]

{ #category : #'event handling' }
ToSelectableTextFieldSelectionElementSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background:
			(e valueOfTokenNamed: #'color-primary-selection-unfocused') ]
]

{ #category : #'event handling' }
ToSelectableTextFieldSelectionElementSkin >> focusedSkinEvent: anEvent [

	super focusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background:
			(e valueOfTokenNamed: #'color-primary-selection-unfocused') ]
]

{ #category : #'event handling' }
ToSelectableTextFieldSelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (e valueOfTokenNamed: #'color-primary-selection-unfocused') ]
]

{ #category : #'event handling' }
ToSelectableTextFieldSelectionElementSkin >> unfocusedSkinEvent: anEvent [

	super unfocusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isEnabled ifTrue: [
			e border: (e valueOfTokenNamed: #'color-primary-selection-focused').
			e background:
				(e valueOfTokenNamed: #'color-primary-selection-unfocused') ] ]
]
