Class {
	#name : #ToStateValue,
	#superclass : #Object,
	#instVars : [
		'value',
		'animationDuration'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #accessing }
ToStateValue >> animationDuration [

	^ animationDuration ifNil: [ animationDuration := 0 ]
]

{ #category : #accessing }
ToStateValue >> animationDuration: aNumber [

	animationDuration := aNumber
]

{ #category : #accessing }
ToStateValue >> applyUpdateOn: anElement [

	| event |
	" send a change request "
	event := ToStateValueChangeLookEvent new
		       stateValue: self;
		       yourself.
	anElement dispatchEvent: event
]

{ #category : #converting }
ToStateValue >> asStateValue [

	^ self
]

{ #category : #accessing }
ToStateValue >> duration: aNumber [

	self animationDuration: aNumber
]

{ #category : #accessing }
ToStateValue >> value: anObject [

	value := anObject
]

{ #category : #accessing }
ToStateValue >> valueIn: anElement [

	^ value isClosure
		  ifTrue: [ value value: anElement ]
		  ifFalse: [ value]
]
