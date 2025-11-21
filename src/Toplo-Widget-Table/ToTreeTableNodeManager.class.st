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

	| content |
	"checkableNode ifTrue: [
			| listElement cbox |
			listElement := aTreeNode holder listElement.
			cbox := listElement newCheckboxInNode: aTreeNode.
			cbox constraintsDo: [ :c | c linear vertical alignCenter ].
			aTreeNode addChild: cbox at: 1 ]."
	aNode initializeStartElement.
	content := ToElement new
		           hMatchParent;
		           vFitContent;
		           yourself.
	content layout: BlLinearLayout horizontal.
	aNode middleElement: content.

	" a table node is built as a linear row with one child for each column"
	self columns ifNotNil: [ :cols |
			cols withIndexDo: [ :column :idx |
					| cellElement |
					cellElement := ToTableListCellElement new
						               id: column key;
						               column: column;
						               matchParent;
						               yourself.
					content addChild: cellElement.
					column
						buildListCellElement: cellElement
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
