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

{ #category : #initialization }
ToExClassHierachyTreeNodeManager >> defaultNodeFactory [ 

	^ [ :holder | ToExTreeSubAndMethNode new ]
]
