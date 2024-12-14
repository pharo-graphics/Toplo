Class {
	#name : #ToListContextMenuSelectionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'event handling' }
ToListContextMenuSelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry:
			(BlRoundedRectangleGeometry
				 cornerRadius: (e valueOfTokenNamed: #'border-radius-SM')).
		e inner geometry:
			(BlRoundedRectangleGeometry
				 cornerRadius: (e valueOfTokenNamed: #'border-radius-SM')).
		e inner border: (BlBorder paint: Color white width: 2).
		e border: (BlBorder
				 paint: (e valueOfTokenNamed: #'border-color-primary-selection')
				 width: (e valueOfTokenNamed: #'border-width-primary-selection')) ]
]
