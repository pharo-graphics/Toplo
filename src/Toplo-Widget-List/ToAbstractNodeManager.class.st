Class {
	#name : #ToAbstractNodeManager,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToAbstractNodeManager >> buildNode: aNode [ 

]

{ #category : #'instance creation' }
ToAbstractNodeManager >> newHolder [

	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
ToAbstractNodeManager >> newNodeContainer [ 

	^ ToNodeContainer new
]

{ #category : #'instance creation' }
ToAbstractNodeManager >> newNodeForHolder: aNodeHolder [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractNodeManager >> unbuildNode: aNode [


]
