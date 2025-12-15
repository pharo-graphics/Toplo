Class {
	#name : #ToTableRowNodeManager,
	#superclass : #ToAbstractNodeManager,
	#traits : 'TToTableNodeManager',
	#classTraits : 'TToTableNodeManager classTrait',
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #initialization }
ToTableRowNodeManager >> buildNode: aNode [

	aNode removeChildren.
	" a table node is built as a linear row with one container for each column"
	self buildColumnsInNode: aNode
]

{ #category : #'instance creation' }
ToTableRowNodeManager >> newHolder [

	^ ToTableRowNodeHolder new
]

{ #category : #'instance creation' }
ToTableRowNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToTableRowNode new
		  id: #row;
		  yourself
]
