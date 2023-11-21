Class {
	#name : 'ToPropertyBorderColorTransitionAnimation',
	#superclass : 'ToPropertyAnimation',
	#instVars : [
		'rawAnimIndex'
	],
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 'initialization' }
ToPropertyBorderColorTransitionAnimation >> initialize [ 

	super initialize.
	rawAnimIndex := IdentityDictionary new
]

{ #category : 'writing' }
ToPropertyBorderColorTransitionAnimation >> newRawAnimationFor: anElement to: aStopBorder [

	| newAnim |
	newAnim := BlColorTransition new
		           duration: self duration asDuration;
		           from: (self property read: anElement) paint color;
		           to: aStopBorder paint color;
		           onStepDo: [ :c :e |
			           self property write: (BlBorder paint: c width: aStopBorder width) to: e ].
	newAnim onFinishedDo: [
		rawAnimIndex removeKey: anElement ifAbsent: [  ].
		self property write: aStopBorder to: anElement ].
	^ newAnim
]

{ #category : 'writing' }
ToPropertyBorderColorTransitionAnimation >> write: aBorder to: anElement [

	| rawAnimation |
	rawAnimIndex
		at: anElement
		ifPresent: [ :anim | anim isRunning ifTrue: [ anim stop ] ].
	rawAnimation := self newRawAnimationFor: anElement to: aBorder.
	rawAnimIndex at: anElement put: rawAnimation.
	anElement addAnimation: rawAnimation
]
