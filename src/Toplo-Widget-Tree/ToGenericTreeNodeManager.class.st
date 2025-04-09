"
I am a ToGenericTreeNodeManager

I hold the logic of building and destroying NodeHolders and TreeNodes whenever the DataSource is updated
"
Class {
	#name : #ToGenericTreeNodeManager,
	#superclass : #ToGenericListNodeManager,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'t - generic node manager' }
ToGenericTreeNodeManager >> buildNode: aNode [

	aNode middleElement: (ToElement new
			 fitContent;
			 yourself).
	nodeBuilder
		cull: aNode middleElement
		cull: aNode holder dataItem
		cull: aNode holder
]

{ #category : #'t - generic node manager' }
ToGenericTreeNodeManager >> defaultNodeFactory [

	^ [ :holder |
	  ToTreeNode new ]
]

{ #category : #'t - generic node manager' }
ToGenericTreeNodeManager >> newHolder [

	^ ToTreeNodeHolder new
]
