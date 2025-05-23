Class {
	#name : #ToClassHierachyTreeNodeManager,
	#superclass : #ToTreeNodeManager,
	#category : #'Toplo-Examples-TopLevel-Tree'
}

{ #category : #initialization }
ToClassHierachyTreeNodeManager >> buildNode: aTreeNode [

	| content |
	content := ToElement new.
	content vFitContent.
	content id: #content.
	content addChild:
		(ToLabel text: aTreeNode holder treeDataItem asString).
	aTreeNode addChild: content
]

{ #category : #'children accessing' }
ToClassHierachyTreeNodeManager >> childrenFromDataItem: aClass [

	^ aClass subclasses asOrderedCollection sort: [ :a :b |
		  a name < b name ]
]

{ #category : #'children accessing' }
ToClassHierachyTreeNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToTreeSubAndMethNode new
]
