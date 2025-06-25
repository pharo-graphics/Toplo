Class {
	#name : #ToExClassHierachyTreeNodeManager,
	#superclass : #ToTreeNodeManager,
	#category : #'Toplo-Examples-TopLevel-Trees'
}

{ #category : #'children accessing' }
ToExClassHierachyTreeNodeManager >> childrenFromDataItem: aClass [

	^ aClass subclasses asOrderedCollection sort: [ :a :b |
		  a name < b name ]
]

{ #category : #'children accessing' }
ToExClassHierachyTreeNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToExTreeSubAndMethNode new
]
