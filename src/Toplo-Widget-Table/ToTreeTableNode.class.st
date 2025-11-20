Class {
	#name : #ToTreeTableNode,
	#superclass : #ToTreeNode,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #accessing }
ToTreeTableNode >> cells [ 

	^ self middleElement children asArray
]

{ #category : #accessing }
ToTreeTableNode >> columns [

	^ self holder listElement columns
]

{ #category : #accessing }
ToTreeTableNode >> divider: aDivider movedBy: aDistance from: aStartLocation [

	| cell |
	cell := self cells at: aDivider cellIndex.
	cell width: cell column startDragWidth + aDistance
]

{ #category : #initialization }
ToTreeTableNode >> freezeCellsWidth [

	| columns index cells last |
	columns := self holder listElement columns.
	index := 1.
	cells := self cells.
	cells allButLastDo: [ :child |
			| col |
			col := columns at: index.
			child updateWidthWith: child width.
			index := index + 1 ].
	columns last resizable ifTrue: [ ^ self ].
	last := cells last.
	last updateWidthWith: last width
]

{ #category : #skin }
ToTreeTableNode >> newRawSkin [ 
	
	^ ToTreeNodeSkin new
]
