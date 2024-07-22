Class {
	#name : #ToListBasicSelectionElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'event handling' }
ToListBasicSelectionElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| border |
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: #'border-radius-SM')).
		border := BlBorderBuilder new
			          paint: (e valueOfTokenNamed: #'color-primary');
			          width:
				          (e valueOfTokenNamed: #'border-width-primary-selection');
			          dashArray: (e valueOfTokenNamed: #'dash-array');
			          build.
		e border: border ]
]
