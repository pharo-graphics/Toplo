Class {
	#name : #ToExShapeCommandApplicationTask,
	#superclass : #ToCommandApplicationTask,
	#instVars : [
		'sortBlock'
	],
	#category : #'Toplo-Examples-Experiments'
}

{ #category : #'api - running' }
ToExShapeCommandApplicationTask >> run [

	sortBlock ifNotNil: [
		commandQueue add: (ToExShapeSortCommand new sortBlock: sortBlock) ].
	super run
]

{ #category : #accessing }
ToExShapeCommandApplicationTask >> sortBlock: aSortBlock [

	sortBlock := aSortBlock
]
