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
		commandQueue add: (ToEnqueuedCommand new
				 applier: self;
				 command: (ToExShapeSortCommand new sortBlock: sortBlock);
				 yourself) ].
	super run
]

{ #category : #accessing }
ToExShapeCommandApplicationTask >> sortBlock: aSortBlock [

	sortBlock := aSortBlock
]
