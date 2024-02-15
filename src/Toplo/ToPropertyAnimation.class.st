Class {
	#name : #ToPropertyAnimation,
	#superclass : #Object,
	#instVars : [
		'finishedAction',
		'rawAnimIndex',
		'property',
		'duration'
	],
	#category : 'Toplo-Core-Theme'
}

{ #category : #accessing }
ToPropertyAnimation >> duration [

	^ duration ifNil: [ duration := 200 milliSeconds ]
]

{ #category : #accessing }
ToPropertyAnimation >> duration: aDuration [

	duration := aDuration
]

{ #category : #initialization }
ToPropertyAnimation >> initialize [ 

	super initialize.
	rawAnimIndex := IdentityDictionary new
]

{ #category : #'instance creation' }
ToPropertyAnimation >> newRawAnimationFor: anElement to: aValue [

	^ self subclassResponsibility 
]

{ #category : #writing }
ToPropertyAnimation >> onFinishedDo: aValuable [
	" aValuable takes the element as argument "

	finishedAction := aValuable
]

{ #category : #accessing }
ToPropertyAnimation >> property [

	^ property
]

{ #category : #accessing }
ToPropertyAnimation >> property: aProperty [

	property := aProperty
]

{ #category : #writing }
ToPropertyAnimation >> write: aValue to: anElement [

	| rawAnimation |
	rawAnimIndex 
		at: anElement
		ifPresent: [ :anim | anim isRunning ifTrue: [ anim stop ] ].
	rawAnimation := self newRawAnimationFor: anElement to: aValue.
	rawAnimation duration: self duration asDuration.
	rawAnimation onFinishedDo: [
		finishedAction ifNotNil: [ :fa | fa value: anElement ].
		self property write: aValue to: anElement.
		rawAnimIndex removeKey: anElement ifAbsent: [  ] ].
	rawAnimIndex at: anElement put: rawAnimation.
	anElement addAnimation: rawAnimation
]
