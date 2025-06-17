Class {
	#name : #ToFloatHolderSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Float'
}

{ #category : #'event handling' }
ToFloatHolderSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e background: Color white.
			e effect: (BlGaussianShadowEffect
					 color: (Color gray alpha: 0.8)
					 width: 30
					 offset: 0 @ 1) ]
]
