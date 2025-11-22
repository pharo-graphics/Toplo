Class {
	#name : #ToTreeNodeManager,
	#superclass : #ToAbstractNodeManager,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'node building' }
ToTreeNodeManager >> buildNode: aTreeNode [

	aTreeNode middleContainer addChild:
		(ToLabel text: aTreeNode holder treeDataItem asString)
]

{ #category : #'children accessing' }
ToTreeNodeManager >> childrenFromDataItem: aDataItem [

	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
ToTreeNodeManager >> newHolder [

	^ ToTreeNodeHolder new
]

{ #category : #'instance creation' }
ToTreeNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToTreeNode new
]
