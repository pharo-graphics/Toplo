Class {
	#name : #ToAccordionListPrimarySelectionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Accordion-List'
}

{ #category : #'event handling' }
ToAccordionListPrimarySelectionElementSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-primary-selection-disabled')
				 width: (e valueOfTokenNamed: #'border-width-primary-selection')).
		e background: BlBackground transparent ]
]

{ #category : #'event handling' }
ToAccordionListPrimarySelectionElementSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty.

		" I must take into account the focused state of the node container element 
		here to start with the right background "
		e isFocused
			ifTrue: [
				e header background:
					(e valueOfTokenNamed: #'color-primary-selection-focused') ]
			ifFalse: [
				e header background:
					(e valueOfTokenNamed: #'color-primary-selection-unfocused') ] ]
]

{ #category : #'event handling' }
ToAccordionListPrimarySelectionElementSkin >> focusedSkinEvent: anEvent [

	super focusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e header background:
			(e valueOfTokenNamed: #'color-primary-selection-focused') ]
]

{ #category : #'event handling' }
ToAccordionListPrimarySelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: #'border-radius-SM')) ]
]

{ #category : #'event handling' }
ToAccordionListPrimarySelectionElementSkin >> unfocusedSkinEvent: anEvent [

	super unfocusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e header background:
			(e valueOfTokenNamed: #'color-primary-selection-unfocused') ]
]
