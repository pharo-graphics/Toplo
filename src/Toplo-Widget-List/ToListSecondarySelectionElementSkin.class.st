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
		e background: (Color veryLightGray alpha: 0.2) ]
]
