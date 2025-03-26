Class {
	#name : #ToPicsumNodeManager,
	#superclass : #ToAbstractNodeManager,
	#category : #'Toplo-Examples-PhotoGalleryParts'
}

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
