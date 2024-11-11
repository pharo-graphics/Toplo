Class {
	#name : #ToRawParallelTransition,
	#superclass : #BlBaseAnimation,
	#instVars : [
		'parallelAnimation',
		'stepAction',
		'stepArray'
	],
	#category : #'Toplo-Support-Transition'
}

{ #category : #'instance creation' }
ToRawParallelTransition class >> withAll: aCollectionOfAnimations [

	^ self new
		  addAll: aCollectionOfAnimations;
		  yourself
]

{ #category : #adding }
ToRawParallelTransition >> add: aTransitionAnimation [

	parallelAnimation add: aTransitionAnimation
]

{ #category : #adding }
ToRawParallelTransition >> addAll: aTransitionAnimationArray [

	parallelAnimation addAll: aTransitionAnimationArray
]

{ #category : #pulse }
ToRawParallelTransition >> applyValue: anArray [

	stepAction valueWithEnoughArguments: { anArray. self target }
]

{ #category : #'api - running' }
ToRawParallelTransition >> doStep [
	"Execute an actual animation step. My subclasses define this hook, and assume it's executed after my internal state has been updated, for example, progress."

	parallelAnimation doStep.
	self applyValue: stepArray 
]

{ #category : #'api - accessing' }
ToRawParallelTransition >> duration [
	"Return animation duration. Duration can not necessarily be set manually, in case
	of composite animations it is computed on-fly based on durations of their sub-animations"

	^ parallelAnimation duration
]

{ #category : #'private - running' }
ToRawParallelTransition >> initStart [

	stepArray := Array new: parallelAnimation animations size.
	parallelAnimation animations withIndexDo: [ :trans :idx |
		trans onStepDo: [ :v :t | stepArray at: idx put: v ] ].
	parallelAnimation initStart.
	super initStart.


]

{ #category : #initialization }
ToRawParallelTransition >> initialize [ 

	super initialize.
	parallelAnimation := BlParallelAnimation new.

]

{ #category : #accessing }
ToRawParallelTransition >> onStepDo: aBlock [

	stepAction := aBlock
]

{ #category : #'api - running' }
ToRawParallelTransition >> stop [

	parallelAnimation stop.
	super stop.

]

{ #category : #accessing }
ToRawParallelTransition >> time: aBlTime [

	parallelAnimation time: aBlTime.
	super time: aBlTime.

]
