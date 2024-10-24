Class {
	#name : #ToExShapeNewGenerationCommand,
	#superclass : #ToExShapeContainerCommand,
	#instVars : [
		'random',
		'size'
	],
	#category : #'Toplo-Examples-Experiments'
}

{ #category : #hook }
ToExShapeNewGenerationCommand >> applyOn: aShapeContainer [

	aShapeContainer shapes: self nextGeneration
]

{ #category : #initialization }
ToExShapeNewGenerationCommand >> initialize [ 

	super initialize.
	random := Random new
]

{ #category : #'private - application' }
ToExShapeNewGenerationCommand >> newCircle [

	| center radius |
	center := random next * 100 @ (random next * 100). "center as a percentage of the bounds"
	radius := random nextBetween: 3 and: 20.
	^ GCircle center: center asGPoint radius: radius
]

{ #category : #'private - application' }
ToExShapeNewGenerationCommand >> nextGeneration [

	^ Array streamContents: [ :stream |
		  1 to: size do: [ :i |
			  | shape model color |
			  color := i <= (size / 2)
				           ifTrue: [ Color blue ]
				           ifFalse: [ Color red ].
			  shape := self newCircle.
			  model := ToExShapeModel new
				           num: i;
				           background: color;
				           shape: shape;
				           yourself.
			  stream nextPut: model ] ]
]

{ #category : #'as yet unclassified' }
ToExShapeNewGenerationCommand >> size: aNumber [

	size := aNumber
]
