Class {
	#name : #ToPropertyColorTransitionAnimation,
	#superclass : #ToPropertyAnimation,
	#category : #'Toplo-Core-StyleSheet'
}

{ #category : #visiting }
ToPropertyColorTransitionAnimation >> accept: aToThemeToSourceCodeVisitor [ 
	aToThemeToSourceCodeVisitor visitPropertyColorTransitionAnimation: self
]

{ #category : #'instance creation' }
ToPropertyColorTransitionAnimation >> newRawAnimationFor: anElement to: aStopColor [

	| newAnim |
	newAnim := BlColorTransition new
		           from: (self property read: anElement);
		           to: aStopColor;
		           onStepDo: [ :c :e | self property write: c to: e ].
	^ newAnim
]
