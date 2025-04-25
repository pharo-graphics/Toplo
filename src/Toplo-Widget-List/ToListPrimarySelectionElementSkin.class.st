Class {
	#name : #ToListPrimarySelectionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'event handling' }
ToListPrimarySelectionElementSkin >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'color-primary-selection-disabled')
				 width: (e valueOfTokenNamed: #'border-width-primary-selection')).
		e background: BlBackground transparent ]
]

{ #category : #'event handling' }
ToListPrimarySelectionElementSkin >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e selectionOption isGrouped
			ifTrue: [
				e border: (BlBorder
						 paint: (e valueOfTokenNamed: #'border-color-primary-selection')
						 width: (e valueOfTokenNamed: #'border-width-primary-selection')) ]
			ifFalse: [ e border: BlBorder empty ].

		" I must take into account the focused state of the node container element 
		here to start with the right background "
		e isBeneath
			ifTrue: [
				e isFocused
					ifTrue: [
						e background:
							(e valueOfTokenNamed: #'color-list-primary-selection-focused') ]
					ifFalse: [
						e background:
							(e valueOfTokenNamed: #'color-list-primary-selection-unfocused') ] ]
			ifFalse: [
				e isFocused
					ifTrue: [
						e background:
							(e valueOfTokenNamed: #'color-list-primary-selection-over-focused') ]
					ifFalse: [
						e background:
							(e valueOfTokenNamed: #'color-list-primary-selection-over-unfocused') ] ] ]
]

{ #category : #'event handling' }
ToListPrimarySelectionElementSkin >> focusedSkinEvent: anEvent [

	super focusedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e isBeneath
			ifTrue: [
				e background:
					(e valueOfTokenNamed: #'color-list-primary-selection-focused') ]
			ifFalse: [
				e background:
					(e valueOfTokenNamed: #'color-list-primary-selection-over-focused') ] ]
]

{ #category : #'event handling' }
ToListPrimarySelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: #'border-radius-SM')) ]
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
