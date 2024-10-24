Class {
	#name : #ToExShapeSortCommand,
	#superclass : #ToExShapeContainerCommand,
	#instVars : [
		'sortBlock'
	],
	#category : #'Toplo-Examples-Experiments'
}

{ #category : #hook }
ToExShapeSortCommand >> applyOn: aShapeContainer [

	| shapes |
	shapes := aShapeContainer shapes asSortedCollection: sortBlock.
	aShapeContainer shapes: shapes asArray 
	
]

{ #category : #accessing }
ToExShapeSortCommand >> sortBlock: anObject [

	sortBlock := anObject
]
