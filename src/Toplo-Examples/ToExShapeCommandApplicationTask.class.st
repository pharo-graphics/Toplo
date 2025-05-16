Class {
	#name : #ToExShapeCommandApplicationTask,
	#superclass : #BlCommandApplicationTask,
	#instVars : [
		'sortBlock'
	],
	#category : #'Toplo-Examples-Experiments'
}

{ #category : #'api - running' }
ToExShapeCommandApplicationTask >> run [

	sortBlock ifNotNil: [
		commandQueue add: (BlEnqueuedCommand new
				 applier: element;
				 command: (ToExShapeSortCommand new sortBlock: sortBlock);
				 yourself) ].
	super run
]

{ #category : #accessing }
ToExShapeCommandApplicationTask >> sortBlock: aSortBlock [

	sortBlock := aSortBlock
]
