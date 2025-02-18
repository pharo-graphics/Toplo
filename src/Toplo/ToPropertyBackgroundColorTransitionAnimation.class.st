Class {
	#name : #ToPropertyBackgroundColorTransitionAnimation,
	#superclass : #ToPropertyAnimation,
	#category : #'Toplo-Core-StyleSheet'
}

{ #category : #'instance creation' }
ToPropertyBackgroundColorTransitionAnimation >> newRawAnimationFor: anElement to: aStopColor [

	| newAnim |
	newAnim := BlColorTransition new
		           from: (self property read: anElement) paint color;
		           to: aStopColor;
		           onStepDo: [ :c :e | self property write: c to: e ].
	^ newAnim
]
