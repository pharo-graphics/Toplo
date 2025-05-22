Class {
	#name : #ToTreeNodeManager,
	#superclass : #ToAbstractNodeManager,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #initialization }
ToTreeNodeManager >> buildNode: aTreeNode [

	aTreeNode middleElement:
		(ToLabel text: aTreeNode holder treeDataItem asString)
]

{ #category : #'children accessing' }
ToTreeNodeManager >> childrenFromDataItem: aDataItem [

	^ self subclassResponsibility 
]

{ #category : #'t - generic node manager' }
ToTreeNodeManager >> newHolder [

	^ ToTreeNodeHolder new
]

{ #category : #'instance creation' }
ToTreeNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToTreeNode new
]
