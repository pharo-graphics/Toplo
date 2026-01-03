Class {
	#name : #ToTreeTableRowNodeManager,
	#superclass : #ToTreeNodeManager,
	#traits : 'TToGenericTreeNodeManager + TToTableRowNodeManager',
	#classTraits : 'TToGenericTreeNodeManager classTrait + TToTableRowNodeManager classTrait',
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'node building' }
ToTreeTableRowNodeManager >> buildNode: aNode [

	self buildColumnsInNode: aNode
]

{ #category : #initialization }
ToTreeTableRowNodeManager >> defaultNodeFactory [ 

	^ [ :holder | ToTreeTableRowNode new ]
]

{ #category : #initialization }
ToTreeTableRowNodeManager >> initialize [ 

	super initialize.
	self initializeAsGenericTreeNodeManager 
]
