Class {
	#name : 'ToPropertyColorTransitionAnimation',
	#superclass : 'ToPropertyAnimation',
	#instVars : [
		'rawAnimation'
	],
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 't - property animation - running' }
ToPropertyColorTransitionAnimation >> isRunning [

	^ rawAnimation notNil and: [rawAnimation isRunning]
]

{ #category : 't - property animation - running' }
ToPropertyColorTransitionAnimation >> stop [

	self isRunning ifFalse: [ ^ self ].
	rawAnimation stop.
	rawAnimation := nil
]

{ #category : 'writing' }
ToPropertyColorTransitionAnimation >> write: aColor to: anElement [

	| currentColor |
	currentColor := self property read: anElement.
	rawAnimation := BlColorTransition new
		             duration: self duration asDuration;
		             from: currentColor;
		             to: aColor;
		             onStepDo: [ :c :e | self property write: c to: e ].
	self finishedHandlers do: [ :h | rawAnimation onFinishedDo: h ].
	rawAnimation onFinishedDo: [ self property write: aColor to: anElement ].
	anElement addAnimation: rawAnimation

]
