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
self flag: 'The column should have a builder '.
	aTableNode removeChildren.
	" a table node is built as a linear row with one child for each column"
	self columns ifNotNil: [ :cols |
			cols do: [ :column |
					| columnPart |
					columnPart := ToElement new
						              id: column key;
						              matchParent;
						              yourself.
					columnPart addChild: (column render: aTableNode holder dataItem).
					aTableNode addChild: columnPart ] ]
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
