Class {
	#name : #ToClassHierachyTreeNodeManager,
	#superclass : #ToTreeNodeManager,
	#category : #'Toplo-Widget-Tree-examples'
}

{ #category : #initialization }
ToClassHierachyTreeNodeManager >> buildNode: aTreeNode [

	aTreeNode middleElement:
		(ToLabel text: aTreeNode holder dataItem asString)
]

{ #category : #'children accessing' }
ToClassHierachyTreeNodeManager >> childrenFromDataItem: aClass [

	^ aClass subclasses asOrderedCollection
]

{ #category : #'instance creation' }
ToClassHierachyTreeNodeManager >> newNodeForHolder: aNodeHolder [

	^  ToTreeNode new
]
