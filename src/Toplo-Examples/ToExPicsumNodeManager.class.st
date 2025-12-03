"
I'm part of the Photo gallery example. I'm not expected to be used as a standalone.
See `ToSandBox class>>#example_PicsumPhotosGallery`
"
Class {
	#name : #ToExPicsumNodeManager,
	#superclass : #ToAbstractNodeManager,
	#category : #'Toplo-Examples-PhotoGalleryParts'
}

{ #category : #'instance creation' }
ToExPicsumNodeManager >> newHolder [

	^ ToExPicsumHolder new
]

{ #category : #'instance creation' }
ToExPicsumNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToExPicsumNode new 
]

{ #category : #initialization }
ToExPicsumNodeManager >> unbuildNode: aNode [

	aNode holder terminateLoader.

]
