Class {
	#name : #ToExClassHierachyTreeNodeManager,
	#superclass : #ToTreeNodeManager,
	#category : #'Toplo-Examples-TopLevel-Trees'
}

{ #category : #initialization }
ToExClassHierachyTreeNodeManager >> buildNode: aNode [ 

	aNode addChild: (ToLabel text: aNode holder dataItem asString)
]

{ #category : #'children accessing' }
ToExClassHierachyTreeNodeManager >> childrenFromDataItem: aClass [

	^ aClass subclasses asOrderedCollection sort: [ :a :b |
		  a name < b name ]
]

{ #category : #initialization }
ToExClassHierachyTreeNodeManager >> defaultNodeFactory [ 

	^ [ :holder | ToExTreeSubAndMethNode new ]
]
