Class {
	#name : #ToTableNodeManager,
	#superclass : #ToAbstractNodeManager,
	#instVars : [
		'columns'
	],
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #initialization }
ToTableNodeManager >> buildNode: aTableNode [

	aTableNode removeChildren.
	" a table node is built as a linear row with one child for each column"
	self columns ifNotNil: [ :cols |
			cols withIndexDo: [ :column :idx |
					| cellElement |
					cellElement := (ToTableListCellContainer
						                holder: aTableNode holder
						                column: column)
						               id: column key;
						               matchParent;
						               yourself.
					aTableNode addChild: cellElement.
					column
						buildListCellInContainer: cellElement
						atIndex: idx
						inNode: aTableNode ] ]
]

{ #category : #accessing }
ToTableNodeManager >> columns [

	^ columns
]

{ #category : #accessing }
ToTableNodeManager >> columns: aTableColumnArray [

	columns := aTableColumnArray
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
