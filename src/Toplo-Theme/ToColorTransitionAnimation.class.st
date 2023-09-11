Class {
	#name : #ToColorTransitionAnimation,
	#superclass : #ToPropertyAnimation,
	#category : #'Toplo-Theme-Look'
}

{ #category : #writing }
ToColorTransitionAnimation >> write: aColor to: anElement [

	| currentColor |
	rawAnimation ifNotNil: [ rawAnimation isRunning ifTrue: [rawAnimation stop ]].
	currentColor := self property read: anElement.
	rawAnimation := BlColorTransition new
		             duration: self duration asDuration;
		             from: currentColor;
		             to: aColor;
		             onStepDo: [ :c :e | self property write: c to: e ].
	anElement addAnimation: rawAnimation.
	rawAnimation onFinishedDo: [ self property write: aColor to: anElement ]

]
