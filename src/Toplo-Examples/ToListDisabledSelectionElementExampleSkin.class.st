Class {
	#name : #ToListDisabledSelectionElementExampleSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Examples'
}

{ #category : #'event handling' }
ToListDisabledSelectionElementExampleSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| border |
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: #'border-radius-SM')).
		border := BlBorderBuilder new
			          paint: (e valueOfTokenNamed: #'color-border-disabled');
			          width:
				          (e valueOfTokenNamed: #'border-width-primary-selection');
			          dashArray: (e valueOfTokenNamed: #'dash-array');
			          build.
		e border: border ]
]
