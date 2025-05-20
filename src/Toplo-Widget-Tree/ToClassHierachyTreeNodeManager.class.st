Class {
	#name : #ToClassHierachyTreeNodeManager,
	#superclass : #ToTreeNodeManager,
	#category : #'Toplo-Widget-Tree-examples'
}

{ #category : #'children accessing' }
ToClassHierachyTreeNodeManager >> childrenFromDataItem: aClass [

	^ aClass subclasses asOrderedCollection sort: [ :a :b |
		  a name < b name ]
]
