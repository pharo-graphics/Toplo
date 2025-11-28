Trait {
	#name : #TToTableNodeManager,
	#instVars : [
		'columns'
	],
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'t - table node manager' }
TToTableNodeManager >> addContainer: aCellContainer inNode: aNode [

	aNode addCellContainer: aCellContainer
]

{ #category : #'t - table node manager' }
TToTableNodeManager >> buildColumnsInNode: aNode [

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
TToTableNodeManager >> columns [

	^ columns
]

{ #category : #'t - table node manager' }
TToTableNodeManager >> columns: aTableColumnArray [

	columns := aTableColumnArray
]
