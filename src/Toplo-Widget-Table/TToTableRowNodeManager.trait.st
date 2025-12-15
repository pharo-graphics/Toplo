Trait {
	#name : #TToTableRowNodeManager,
	#instVars : [
		'columns'
	],
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'t - table node manager' }
TToTableRowNodeManager >> addContainer: aCellContainer inNode: aNode [

	aNode addCellContainer: aCellContainer
]

{ #category : #'t - table node manager' }
TToTableRowNodeManager >> buildColumnsInNode: aNode [

	" a table node is built as a linear row with one container for each column"
	self columns ifNotNil: [ :cols |
			cols withIndexDo: [ :column :idx |
					| container |
					container := (ToTableListCellContainer
						              holder: aNode holder
						              column: column)
						             id: column key;
						             yourself.
					self addContainer: container inNode: aNode.
					column
						buildListCellInContainer: container
						atIndex: idx
						inNode: aNode ] ]
]

{ #category : #'t - table node manager' }
TToTableRowNodeManager >> columns [

	^ columns
]

{ #category : #'t - table node manager' }
TToTableRowNodeManager >> columns: aTableColumnArray [

	columns := aTableColumnArray
]
