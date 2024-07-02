Class {
	#name : #ToListUnselectableSelectionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'event handling' }
ToListUnselectableSelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| border |
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: #'border-radius-SM')).
		border := BlBorderBuilder new
			          paint:
				          (e valueOfTokenNamed: #'border-color-danger-selection');
			          width:
				          (e valueOfTokenNamed: #'border-width-primary-selection');
			          dashArray: (e valueOfTokenNamed: #'dash-array');
			          build.
		e border: border ]
]
