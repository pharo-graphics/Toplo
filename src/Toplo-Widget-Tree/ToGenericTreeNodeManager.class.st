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

	| dataItem |
	dataItem := aNode holder dataItem.
	aNode middleElement: (ToLabel text: dataItem asString)
]

{ #category : #initialization }
ToGenericTreeNodeManager >> constraintNode: aNode [

	aNode
		hMatchParent;
		vFitContent
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
