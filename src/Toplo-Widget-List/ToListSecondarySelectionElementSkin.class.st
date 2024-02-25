Class {
	#name : #ToListSecondarySelectionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'event handling' }
ToListSecondarySelectionElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry:
			((e valueOfTokenNamed: #'primary-selection-geometry-class')
				 cornerRadius: (e valueOfTokenNamed: #'border-radius-SM')).
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'border-color-primary-selection')
				 width: (e valueOfTokenNamed: #'border-width-primary-selection')) ]
]
