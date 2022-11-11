Class {
	#name : #ToStateButtonEngine,
	#superclass : #Object,
	#instVars : [
		'step'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #processing }
ToStateButtonEngine >> startOn: aButton [

	step ifNil: [ ^ self ].
	step startOn: aButton
]

{ #category : #initialization }
ToStateButtonEngine >> states: aStateCollection transitions: aTransitionCollection [

	| curr transitions state |
	step := nil.
	self assert: aStateCollection size = aTransitionCollection size.
	aTransitionCollection ifEmpty: [ ^ self ].
	transitions := OrderedCollection newFrom: aTransitionCollection.
	state := aStateCollection detect: [ :s | s name = transitions first name ] ifNone: [ ^ self ].
	step := ToStateButtonEngineStep state: state transition: transitions removeFirst.
	curr := step.
	[ transitions isEmpty ] whileFalse: [ 
		state := aStateCollection detect: [ :s | s name = transitions first name ] ifNone: [ step := nil. ^ self ].
		curr next: (ToStateButtonEngineStep state: state transition: transitions removeFirst).
		curr := curr next ].
	curr next: step
]

{ #category : #processing }
ToStateButtonEngine >> stepOn: aButton [
	step ifNil: [ ^ self ].
	step applyOn: aButton.
	step := step next
]
