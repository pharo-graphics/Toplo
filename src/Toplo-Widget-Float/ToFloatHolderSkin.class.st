Class {
	#name : #ToFloatHolderSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Float'
}

{ #category : #'event handling' }
ToFloatHolderSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e constraintsDo: [ :c |
					c linear vertical alignCenter.
					c linear horizontal alignCenter ].
			e background: (e valueOfTokenNamed: #'background-color').
			e geometry: (BlRoundedRectangleGeometry cornerRadius:
					 (e valueOfTokenNamed: #'border-radius')).
			e effect: (BlGaussianShadowEffect
					 color: (Color lightGray alpha: 0.6)
					 width: 20
					 offset: 0 @ 0) ]
]
