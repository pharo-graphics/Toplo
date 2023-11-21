Class {
	#name : 'ToPropertyColorTransitionAnimation',
	#superclass : 'ToPropertyAnimation',
	#instVars : [
		'rawAnimIndex'
	],
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 'initialization' }
ToPropertyColorTransitionAnimation >> initialize [ 

	super initialize.
	rawAnimIndex := IdentityDictionary new
]

{ #category : 'writing' }
ToPropertyColorTransitionAnimation >> newRawAnimationFor: anElement to: aStopColor [

	| newAnim |
	newAnim := BlColorTransition new
		           duration: self duration asDuration;
		           from: (self property read: anElement);
		           to: aStopColor;
		           onStepDo: [ :c :e | self property write: c to: e ].
	newAnim onFinishedDo: [
		self property write: aStopColor to: anElement.
		rawAnimIndex removeKey: anElement ifAbsent: [  ] ].
	rawAnimIndex at: anElement put: newAnim.
	^ newAnim
]

{ #category : 'writing' }
ToPropertyColorTransitionAnimation >> write: aColor to: anElement [

	| rawAnimation |
	rawAnimIndex
		at: anElement
		ifPresent: [ :anim | anim isRunning ifTrue: [ anim stop ] ].
	rawAnimation := self newRawAnimationFor: anElement to: aColor.
	rawAnimIndex at: anElement put: rawAnimation.
	anElement addAnimation: rawAnimation
]
