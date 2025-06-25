Class {
	#name : #ToExShapeCommandApplicationStrategy,
	#superclass : #BlQueueBasedCommandApplicationStrategy,
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
