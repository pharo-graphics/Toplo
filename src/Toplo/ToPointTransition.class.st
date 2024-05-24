Class {
	#name : #ToPointTransition,
	#superclass : #BlBaseAnimation,
	#instVars : [
		'rawTransition',
		'from',
		'stepAction',
		'to',
		'duration'
	],
	#category : #'Toplo-Support'
}

{ #category : #pulse }
ToPointTransition >> applyValue: aValue [

	stepAction valueWithEnoughArguments: { aValue. self target }
]

{ #category : #'api - running' }
ToPointTransition >> doStep [
	"Execute an actual animation step. My subclasses define this hook, and assume it's executed after my internal state has been updated, for example, progress."

	rawTransition doStep
]

{ #category : #'api - accessing' }
ToPointTransition >> duration [
	"Return animation duration. Duration can not necessarily be set manually, in case
	of composite animations it is computed on-fly based on durations of their sub-animations.
	Note: My duration should not take my own delay into account"

	^ duration
]

{ #category : #accessing }
ToPointTransition >> duration: aDuration [

	duration := aDuration
]

{ #category : #accessing }
ToPointTransition >> from: aPoint [

	from := aPoint
]

{ #category : #'private - running' }
ToPointTransition >> initStart [

	super initStart.
	rawTransition add: (BlNumberTransition new
			 duration: duration;
			 from: from x;
			 to: to x;
			 yourself).
	rawTransition add: (BlNumberTransition new
			 duration: duration;
			 from: from y;
			 to: to y;
			 yourself).
	rawTransition onStepDo: [ :array :aTarget |
		| p |
		p := array first @ array second.
		self applyValue: p ].

	rawTransition initStart.


]

{ #category : #initialization }
ToPointTransition >> initialize [

	super initialize.
	rawTransition := ToRawParallelTransition new
]

{ #category : #accessing }
ToPointTransition >> onStepDo: aValuable [
	" aValuable takes two optional arguments: first the new position point and second the target "

	stepAction := aValuable 
]

{ #category : #accessing }
ToPointTransition >> to: aPoint [

	to := aPoint
]
