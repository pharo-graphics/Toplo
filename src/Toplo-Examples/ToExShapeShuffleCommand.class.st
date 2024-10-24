Class {
	#name : #ToExShapeShuffleCommand,
	#superclass : #ToExShapeContainerCommand,
	#instVars : [
		'random'
	],
	#category : #'Toplo-Examples-Experiments'
}

{ #category : #hook }
ToExShapeShuffleCommand >> applyOn: aShapeContainer [

	| shapes |
	shapes := aShapeContainer shapes.
	shapes do: [ :s |
		s shape: (self movedCircle: s) ].
	aShapeContainer invalidate
]

{ #category : #initialization }
ToExShapeShuffleCommand >> initialize [ 

	super initialize.
	random := Random new
]

{ #category : #initialization }
ToExShapeShuffleCommand >> movedCircle: aCircle [

	| center radius |
	center := random next * 100 @ (random next * 100). "center as a percentage of the bounds"
	radius := aCircle shape radius.
	^ GCircle center: center asGPoint radius: radius
]
