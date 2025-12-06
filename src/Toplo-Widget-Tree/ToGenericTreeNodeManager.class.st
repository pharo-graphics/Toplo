"
I am a ToGenericTreeNodeManager

I hold the logic of building and destroying NodeHolders and TreeNodes whenever the DataSource is updated
"
Class {
	#name : #ToGenericTreeNodeManager,
	#superclass : #ToTreeNodeManager,
	#traits : 'TToGenericNodeManager + TToGenericTreeNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait + TToGenericTreeNodeManager classTrait',
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'node building' }
ToGenericTreeNodeManager >> buildNode: aTreeNode [
	
	nodeBuilder
		cull: aTreeNode 
		cull: aTreeNode holder treeDataItem
		cull: aTreeNode holder.

]

{ #category : #'t - generic node manager' }
ToGenericTreeNodeManager >> defaultNodeFactory [

	^ [ :holder |
	  ToTreeNode new ]
]

{ #category : #'t - generic node manager' }
ToGenericTreeNodeManager >> defaultNodeHolderFactory [

	^ [ ToTreeNodeHolder new ]
]

{ #category : #initialization }
ToGenericTreeNodeManager >> initialize [ 

	super initialize.
	self initializeAsGenericNodeManager.
	self initializeAsGenericTreeNodeManager
]
