Class {
	#name : 'ToGaussianEffectOpacityAnimation',
	#superclass : 'BlGaussianEffectOpacityAnimation',
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 'pulse' }
ToGaussianEffectOpacityAnimation >> applyValue: anOpacity [

	self target effect: (BlGaussianShadowEffect
			 color: (self color alphaMixed: anOpacity with: Color white)
			 width: self width
			 offset: 0 @ 0).
]
