Class {
	#name : #ToAbstractNodeManager,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'instance creation' }
ToAbstractNodeManager >> buildNode: aNode [ 

	self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractNodeManager >> constraintNode: aNode [

	aNode hMatchParent
]

{ #category : #'instance creation' }
ToAbstractNodeManager >> newHolder [

	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
ToAbstractNodeManager >> newNodeForHolder: aNodeHolder [

	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
ToAbstractNodeManager >> unbuildNode: aNode [

	self subclassResponsibility 

]
