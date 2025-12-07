"
I am a ToGenericTreeNodeManager

I hold the logic of building and destroying NodeHolders and TreeNodes whenever the DataSource is updated
"
Class {
	#name : #ToTreeGenericNodeManager,
	#superclass : #ToTreeNodeManager,
	#traits : 'TToGenericNodeManager + TToGenericTreeNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait + TToGenericTreeNodeManager classTrait',
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'node building' }
ToTreeGenericNodeManager >> buildNode: aTreeNode [
	
	nodeBuilder
		cull: aTreeNode 
		cull: aTreeNode holder dataItem
		cull: aTreeNode holder.

]

{ #category : #'t - generic node manager' }
ToTreeGenericNodeManager >> defaultNodeFactory [

	^ [ :holder |
	  ToTreeNode new ]
]

{ #category : #'t - generic node manager' }
ToTreeGenericNodeManager >> defaultNodeHolderFactory [

	^ [ ToTreeNodeHolder new ]
]

{ #category : #initialization }
ToTreeGenericNodeManager >> initialize [ 

	super initialize.
	self initializeAsGenericNodeManager.
	self initializeAsGenericTreeNodeManager
]
