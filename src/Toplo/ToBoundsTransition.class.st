Class {
	#name : #ToBoundsTransition,
	#superclass : #BlBaseAnimation,
	#instVars : [
		'from',
		'stepAction',
		'to',
		'duration',
		'parallelAnimation',
		'stepPosition',
		'stepSize'
	],
	#category : #'Toplo-Support'
}

{ #category : #pulse }
ToBoundsTransition >> applyValue: aValue [

	stepAction valueWithEnoughArguments: { aValue. self target }
]

{ #category : #'api - running' }
ToBoundsTransition >> doStep [
	"Execute an actual animation step. My subclasses define this hook, and assume it's executed after my internal state has been updated, for example, progress."

	parallelAnimation doStep.
	self applyValue: (stepPosition extent: stepSize)
]

{ #category : #'api - accessing' }
ToBoundsTransition >> duration [

	^ duration
]

{ #category : #accessing }
ToBoundsTransition >> duration: aDuration [

	duration := aDuration
]

{ #category : #accessing }
ToBoundsTransition >> from: anObject [

	from := anObject
]

{ #category : #'private - running' }
ToBoundsTransition >> initStart [

	super initStart.
	parallelAnimation addAll: {
			(ToPointTransition new
				 from: from origin;
				 to: to origin;
				 duration: duration;
				 onStepDo: [ :aPosition :aTarget |
					 stepPosition := aPosition ]).
			(ToPointTransition new
				 from: from extent;
				 to: to extent;
				 duration: duration;
				 onStepDo: [ :aSize :aTarget |
					 stepSize := aSize ]) }.

	parallelAnimation initStart
]

{ #category : #initialization }
ToBoundsTransition >> initialize [

	super initialize.
	parallelAnimation := BlParallelAnimation new
]

{ #category : #enumerating }
ToBoundsTransition >> onStepDo: aValuable [
	" aValuable takes two optional arguments: first the new position point and second the target "

	stepAction := aValuable 
]

{ #category : #accessing }
ToBoundsTransition >> stepAction: anObject [

	stepAction := anObject
]

{ #category : #accessing }
ToBoundsTransition >> to: anObject [

	to := anObject
]
