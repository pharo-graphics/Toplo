Class {
	#name : #ToListSecondarySelectionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'event handling' }
ToListSecondarySelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry:
			(BlRoundedRectangleGeometry
				 cornerRadius: (e valueOfTokenNamed: #'border-radius-SM')).
		e background: (e valueOfTokenNamed: #'color-secondary-selection') ]
]
