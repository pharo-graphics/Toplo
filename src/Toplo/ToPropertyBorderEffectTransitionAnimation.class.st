Class {
	#name : #ToPropertyBorderEffectTransitionAnimation,
	#superclass : #ToPropertyAnimation,
	#category : 'Toplo-Core-StyleSheet'
}

{ #category : #'instance creation' }
ToPropertyBorderEffectTransitionAnimation >> newRawAnimationFor: anElement to: aStopBorder [

	| newAnim origEffect |
	origEffect := anElement effect.
	newAnim := ToGaussianEffectOpacityAnimation new
		           color: (self property read: anElement) paint color;
		           opacity: 0.2;
		           width: 10.
	newAnim onFinishedDo: [ anElement effect: origEffect ].
	^ newAnim
]
