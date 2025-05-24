Class {
	#name : #ToClassHierachyTreeNodeManager,
	#superclass : #ToTreeNodeManager,
	#category : #'Toplo-Examples-TopLevel-Trees'
}

{ #category : #'children accessing' }
ToClassHierachyTreeNodeManager >> childrenFromDataItem: aClass [

	^ aClass subclasses asOrderedCollection sort: [ :a :b |
		  a name < b name ]
]

{ #category : #'children accessing' }
ToClassHierachyTreeNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToTreeSubAndMethNode new
]
