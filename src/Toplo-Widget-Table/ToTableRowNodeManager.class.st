Class {
	#name : #ToTableRowNodeManager,
	#superclass : #ToBasicListNodeManager,
	#traits : 'TToTableRowNodeManager',
	#classTraits : 'TToTableRowNodeManager classTrait',
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #initialization }
ToTableRowNodeManager >> buildNode: aNode [

	aNode removeChildren.
	" a table node is built as a linear row with one container for each column"
	self buildColumnsInNode: aNode
]

{ #category : #initialization }
ToTableRowNodeManager >> defaultNodeFactory [ 

	^ [ :holder | ToTableRowNode new
		  id: #row;
		  yourself ]
]
