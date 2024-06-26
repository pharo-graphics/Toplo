Class {
	#name : #ToListPrimarySelectionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'event handling' }
ToListPrimarySelectionElementSkin >> focusedSkinEvent: anEvent [

	super focusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isBeneath
			ifTrue: [
				e background:
					(e valueOfTokenNamed: #'color-primary-selection-focused') ]
			ifFalse: [
				e background:
					(e valueOfTokenNamed: #'color-primary-selection-over-focused') ] ]
]

{ #category : #'event handling' }
ToListPrimarySelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: #'border-radius-SM')).

		e selectionOption isGrouped ifTrue: [
			e border: (BlBorder
					 paint: (e valueOfTokenNamed: #'border-color-primary-selection')
					 width: (e valueOfTokenNamed: #'border-width-primary-selection')) ].
	
		" I must take into account the focused state of the node container element here to start with the right background "
		e isBeneath
			ifTrue: [
				e isFocused
					ifTrue: [
						e background:
							(e valueOfTokenNamed: #'color-primary-selection-focused') ]
					ifFalse: [
						e background:
							(e valueOfTokenNamed: #'color-primary-selection-unfocused') ] ]
			ifFalse: [
				e isFocused
					ifTrue: [
						e background:
							(e valueOfTokenNamed: #'color-primary-selection-over-focused') ]
					ifFalse: [
						e background:
							(e valueOfTokenNamed: #'color-primary-selection-over-unfocused') ] ] ]
]

{ #category : #'event handling' }
ToListPrimarySelectionElementSkin >> unfocusedSkinEvent: anEvent [

	super unfocusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		 e isBeneath
			ifTrue: [
				e background:
					(e valueOfTokenNamed: #'color-primary-selection-unfocused') ]
			ifFalse: [
				e background:
					(e valueOfTokenNamed: #'color-primary-selection-over-unfocused') ]]
]
