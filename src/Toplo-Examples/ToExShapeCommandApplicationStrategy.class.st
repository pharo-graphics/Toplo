Class {
	#name : #ToExShapeCommandApplicationStrategy,
	#superclass : #ToQueueBasedCommandApplicationStrategy,
	#category : #'Toplo-Examples-Experiments'
}

{ #category : #accessing }
ToExShapeCommandApplicationStrategy >> newCommandApplicationTask [ 

	^ ToExShapeCommandApplicationTask new
]

{ #category : #accessing }
ToExShapeCommandApplicationStrategy >> sortBlock: aSortBlock [

	applicationTask sortBlock: aSortBlock
]
