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
			cols do: [ :column |
					| columnPart |
					columnPart := ToElement new
						              id: column key;
						              matchParent;
						              yourself.
					aTableNode addChild: columnPart.
					column buildColumnPart: columnPart fromNode: aTableNode ] ]
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
