Class {
	#name : #ToPropertyColorTransitionAnimation,
	#superclass : #ToPropertyAnimation,
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #writing }
ToPropertyColorTransitionAnimation >> write: aColor to: anElement [

	| currentColor |
	currentColor := self property read: anElement.
	rawAnimation := BlColorTransition new
		             duration: self duration asDuration;
		             from: currentColor;
		             to: aColor;
		             onStepDo: [ :c :e | self property write: c to: e ].
	anElement addAnimation: rawAnimation.
	rawAnimation onFinishedDo: [ self property write: aColor to: anElement ]

]
