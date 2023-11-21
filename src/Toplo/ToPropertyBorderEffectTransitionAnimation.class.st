Class {
	#name : 'ToPropertyBorderEffectTransitionAnimation',
	#superclass : 'ToPropertyAnimation',
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 'writing' }
ToPropertyBorderEffectTransitionAnimation >> newRawAnimationFor: anElement to: aStopBorder [

	| newAnim origEffect |
	origEffect := anElement effect.
	newAnim := BlGaussianEffectOpacityAnimation new
		           color: (self property read: anElement) paint color;
		           widthTransition: true;
		           opacity: 0.6;
		           width: 20.
	newAnim onFinishedDo: [ anElement effect: origEffect ].
	^ newAnim
]
