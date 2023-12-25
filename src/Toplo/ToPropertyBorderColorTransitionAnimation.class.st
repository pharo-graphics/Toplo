Class {
	#name : #ToPropertyBorderColorTransitionAnimation,
	#superclass : #ToPropertyAnimation,
	#category : 'Toplo-Core-StyleSheet'
}

{ #category : #'instance creation' }
ToPropertyBorderColorTransitionAnimation >> newRawAnimationFor: anElement to: aStopBorder [

	| newAnim |
	newAnim := BlColorTransition new
		           from: (self property read: anElement) paint color;
		           to: aStopBorder paint color;
		           onStepDo: [ :c :e |
			           self property
				           write: (BlBorder paint: c width: aStopBorder width)
				           to: e ].
	^ newAnim
]
