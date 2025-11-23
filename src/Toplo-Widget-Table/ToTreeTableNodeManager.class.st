Class {
	#name : #ToTreeTableNodeManager,
	#superclass : #ToTreeNodeManager,
	#traits : 'TToGenericTreeNodeManager',
	#classTraits : 'TToGenericTreeNodeManager classTrait',
	#instVars : [
		'columns'
	],
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'node building' }
ToTreeTableNodeManager >> buildNode: aNode [

	aNode initializeStartContainer.

	" a table node is built as a linear row with one child for each column"
	self columns ifNotNil: [ :cols |
			cols withIndexDo: [ :column :idx |
					| cellElement |
					cellElement := (ToTableListCellContainer
						                holder: aNode holder
						                column: column)
						               id: column key;
						               matchParent;
						               yourself.
					aNode middleContainer addChild: cellElement.
					column
						buildListCellInContainer: cellElement
						atIndex: idx
						inNode: aNode ] ]
]

{ #category : #accessing }
ToTreeTableNodeManager >> columns [

	^ columns
]

{ #category : #accessing }
ToTreeTableNodeManager >> columns: aTableColumnArray [

	columns := aTableColumnArray
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
