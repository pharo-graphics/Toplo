Class {
	#name : #ToExShapeRemoveCommand,
	#superclass : #ToExShapeContainerCommand,
	#instVars : [
		'indexes'
	],
	#category : #'Toplo-Examples-Experiments'
}

{ #category : #hook }
ToExShapeRemoveCommand >> applyOn: aShapeContainer [

	| shapes |
	shapes := aShapeContainer shapes asOrderedCollection.
	indexes do: [ :idx |
		idx < shapes size ifTrue: [ shapes removeAt: idx ] ].
	aShapeContainer shapes: shapes asArray
]

{ #category : #accessing }
ToExShapeRemoveCommand >> indexes: anIntegerArray [

	indexes := anIntegerArray
]
