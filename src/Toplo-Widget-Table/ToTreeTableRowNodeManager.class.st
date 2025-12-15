Class {
	#name : #ToTreeTableRowNodeManager,
	#superclass : #ToTreeNodeManager,
	#traits : 'TToGenericTreeNodeManager + TToTableNodeManager',
	#classTraits : 'TToGenericTreeNodeManager classTrait + TToTableNodeManager classTrait',
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'node building' }
ToTreeTableRowNodeManager >> buildNode: aNode [

	self buildColumnsInNode: aNode
]

{ #category : #initialization }
ToTreeTableRowNodeManager >> initialize [ 

	super initialize.
	self initializeAsGenericTreeNodeManager 
]

{ #category : #'t - generic node manager' }
ToTreeTableRowNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToTreeTableRowNode new
]
