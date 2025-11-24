Class {
	#name : #ToTreeTableNodeManager,
	#superclass : #ToTreeNodeManager,
	#traits : 'TToGenericTreeNodeManager + TToTableNodeManager',
	#classTraits : 'TToGenericTreeNodeManager classTrait + TToTableNodeManager classTrait',
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'node building' }
ToTreeTableNodeManager >> buildNode: aNode [

	aNode initializeStartContainer.
	self buildColumnsInNode: aNode
]

{ #category : #initialization }
ToTreeTableNodeManager >> initialize [ 

	super initialize.
	self initializeAsGenericTreeNodeManager 
]

{ #category : #'t - generic node manager' }
ToTreeTableNodeManager >> newHolder [

	^ ToTreeNodeHolder new
]

{ #category : #'t - generic node manager' }
ToTreeTableNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToTreeTableNode new
]
