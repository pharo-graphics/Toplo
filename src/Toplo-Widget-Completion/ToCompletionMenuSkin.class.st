Class {
	#name : #ToCompletionMenuSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Completion'
}

{ #category : #'event handling' }
ToCompletionMenuSkin >> installSkinEvent: anEvent [ 

	super installSkinEvent: anEvent.
	
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'background-color').
		e geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
		e border: (BlBorder paint: Color veryLightGray width: 2 ) ]
]
