"
I am a ToGenericTreeNodeManager

I hold the logic of building and destroying NodeHolders and TreeNodes whenever the DataSource is updated
"
Class {
	#name : #ToGenericTreeNodeManager,
	#superclass : #ToGenericListNodeManager,
	#instVars : [
		'treeElement'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'t - generic node manager' }
ToGenericTreeNodeManager >> buildNode: aNode [

	| dataItem |
	dataItem := aNode holder dataItem.
	aNode addChild: (ToTripletElement new
			 middleElement: (ToLabel text: dataItem asString);
			 startInterspace: 5)
]

{ #category : #initialization }
ToGenericTreeNodeManager >> constraintNode: aNode [ 

	aNode hMatchParent; vFitContent 
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultNodeFactory [

	^ [ :holder |
	  ToTreeNode new ]
]

{ #category : #initialization }
ToGenericTreeNodeManager >> defaultNodeUnbuilder [

	^ [ :node :dataItem :holder | ]
]

{ #category : #'t - generic node manager' }
ToGenericTreeNodeManager >> newHolder [

	^ ToTreeNodeHolder new
]
