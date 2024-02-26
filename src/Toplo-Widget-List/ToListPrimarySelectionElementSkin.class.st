Class {
	#name : #ToListPrimarySelectionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'event handling' }
ToListPrimarySelectionElementSkin >> focusedLookEvent: anEvent [

	super focusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background:
			(e valueOfTokenNamed: #'color-primary-selection-focused') ]
]

{ #category : #'event handling' }
ToListPrimarySelectionElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry:
			(BlRoundedRectangleGeometry
				 cornerRadius: (e valueOfTokenNamed: #'border-radius-SM')).
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'border-color-primary-selection')
				 width: (e valueOfTokenNamed: #'border-width-primary-selection')).
		" I must take into account the focused state of the infinite element to start with the right background "
		e listElement hasFocus
			ifTrue: [ 
				e background: (e valueOfTokenNamed: #'color-primary-selection-focused') ]
			ifFalse: [
				e background: (e valueOfTokenNamed: #'color-primary-selection-unfocused') ].
		"e padding: (BlInsets
				 horizontal: (e valueOfTokenNamed: #'list-padding-H')
				 vertical: (e valueOfTokenNamed: #'list-padding-V'))" ]
]

{ #category : #'event handling' }
ToListPrimarySelectionElementSkin >> unfocusedLookEvent: anEvent [

	super unfocusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e background:
			(e valueOfTokenNamed: #'color-primary-selection-unfocused') ]
]
