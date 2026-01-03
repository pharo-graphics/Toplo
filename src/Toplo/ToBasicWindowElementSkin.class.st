Class {
	#name : #ToBasicWindowElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Core-Window'
}

{ #category : #'event handling' }
ToBasicWindowElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e geometry: (BlRoundedRectangleGeometry cornerRadius:
					 (e valueOfTokenNamed: #'border-radius-SM')).
			e border: (e valueOfTokenNamed: #'color-border').
			e background: (e valueOfTokenNamed: #'color-bg-container').
			e outskirts: BlOutskirts outside ]
]
