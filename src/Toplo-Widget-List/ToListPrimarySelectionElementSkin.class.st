Class {
	#name : #ToListPrimarySelectionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'event handling' }
ToListPrimarySelectionElementSkin >> focusedLookEvent: anEvent [

	super focusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e beneath
			ifTrue: [
				e background:
					(e valueOfTokenNamed: #'color-primary-selection-focused') ]
			ifFalse: [
				e background:
					(e valueOfTokenNamed: #'color-primary-selection-over-focused') ] ]
]

{ #category : #'event handling' }
ToListPrimarySelectionElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: #'border-radius-SM')).

		e option isGrouped ifTrue: [
			e border: (BlBorder
					 paint: (e valueOfTokenNamed: #'border-color-primary-selection')
					 width: (e valueOfTokenNamed: #'border-width-primary-selection')) ].
	
		" I must take into account the focused state of the node container element here to start with the right background "
		e beneath
			ifTrue: [
				e listElement hasFocus
					ifTrue: [
						e background:
							(e valueOfTokenNamed: #'color-primary-selection-focused') ]
					ifFalse: [
						e background:
							(e valueOfTokenNamed: #'color-primary-selection-unfocused') ] ]
			ifFalse: [
				e listElement hasFocus
					ifTrue: [
						e background:
							(e valueOfTokenNamed: #'color-primary-selection-over-focused') ]
					ifFalse: [
						e background:
							(e valueOfTokenNamed: #'color-primary-selection-over-unfocused') ] ] ]
]

{ #category : #'event handling' }
ToListPrimarySelectionElementSkin >> unfocusedLookEvent: anEvent [

	super unfocusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		 e beneath
			ifTrue: [
				e background:
					(e valueOfTokenNamed: #'color-primary-selection-unfocused') ]
			ifFalse: [
				e background:
					(e valueOfTokenNamed: #'color-primary-selection-over-unfocused') ]]
]
