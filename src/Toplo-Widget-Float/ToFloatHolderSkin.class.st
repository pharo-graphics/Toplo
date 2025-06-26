Class {
	#name : #ToFloatHolderSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Float'
}

{ #category : #'event handling' }
ToFloatHolderSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
			e background: (e valueOfTokenNamed: #'background-color').
			e effect: (BlGaussianShadowEffect
					 color: (Color lightGray alpha: 0.6)
					 width: 20
					 offset: 0 @ 0) ]
]
