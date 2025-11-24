Class {
	#name : #ToTableNodeManager,
	#superclass : #ToAbstractNodeManager,
	#traits : 'TToTableNodeManager',
	#classTraits : 'TToTableNodeManager classTrait',
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #initialization }
ToTableNodeManager >> buildNode: aNode [

	aNode removeChildren.
	" a table node is built as a linear row with one container for each column"
	self buildColumnsInNode: aNode
]

{ #category : #'instance creation' }
ToTableNodeManager >> newHolder [

	^ ToTableNodeHolder new
]

{ #category : #'instance creation' }
ToTableNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToTableNode new
		  id: #row;
		  yourself
]
