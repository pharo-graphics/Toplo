Class {
	#name : #ToPicsumNodeManager,
	#superclass : #ToAbstractNodeManager,
	#category : #'Toplo-Examples-PhotoGalleryParts'
}

{ #category : #initialization }
ToPicsumNodeManager >> constraintNode: aNode [

	aNode constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ]
]

{ #category : #'instance creation' }
ToPicsumNodeManager >> newHolder [

	^ ToPicsumHolder new
]

{ #category : #'instance creation' }
ToPicsumNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToPicsumNode new 
]

{ #category : #initialization }
ToPicsumNodeManager >> unbuildNode: aNode [

	aNode holder terminateLoader.

]
