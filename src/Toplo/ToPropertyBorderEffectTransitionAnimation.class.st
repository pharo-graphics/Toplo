Class {
	#name : 'ToPropertyBorderEffectTransitionAnimation',
	#superclass : 'ToPropertyAnimation',
	#instVars : [
		'rawAnimIndex'
	],
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 'initialization' }
ToPropertyBorderEffectTransitionAnimation >> initialize [ 

	super initialize.
	rawAnimIndex := IdentityDictionary new
]

{ #category : 'writing' }
ToPropertyBorderEffectTransitionAnimation >> newRawAnimationFor: anElement to: aStopBorder [

	| newAnim origEffect |
	rawAnimIndex at: anElement ifPresent: [ :anim | anim stop ].
	origEffect := anElement effect.
	newAnim := BlGaussianEffectOpacityAnimation new
		           duration: self duration asDuration;
		           color: (self property read: anElement) paint color;
		           widthTransition: true;
		           opacity: 0.5;
		           width: 20.
	newAnim onFinishedDo: [
		rawAnimIndex removeKey: anElement ifAbsent: [  ].
		anElement effect: origEffect.
		self property write: aStopBorder to: anElement ].
	rawAnimIndex at: anElement put: newAnim.
	^ newAnim
]

{ #category : 'writing' }
ToPropertyBorderEffectTransitionAnimation >> write: aBorder to: anElement [

	| rawAnimation |
	rawAnimIndex
		at: anElement
		ifPresent: [ :anim | anim isRunning ifTrue: [ anim stop ] ].
	rawAnimation := self newRawAnimationFor: anElement to: aBorder.
	rawAnimIndex at: anElement put: rawAnimation.
	anElement addAnimation: rawAnimation
]
