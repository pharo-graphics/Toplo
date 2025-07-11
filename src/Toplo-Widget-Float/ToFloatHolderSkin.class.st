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
			e margin: (BlInsets all: 4).
			e effect:
				(BlGaussianShadowEffect color: Color gray width: 8 offset: 1 @ 1) "alpha: 0.6" ]
]
