Class {
	#name : #ToTableNode,
	#superclass : #ToListNode,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #accessing }
ToTableNode >> cells [ 

	^ self children asArray
]

{ #category : #accessing }
ToTableNode >> columns [

	^ self holder listElement columns
]

{ #category : #accessing }
ToTableNode >> divider: aDivider movedBy: aDistance from: aStartLocation [

	| cell listElement state |
	listElement := self holder listElement.
	state := listElement cellStateAt: aDivider cellIndex.
	cell := self cells at: aDivider cellIndex.
	cell width: state startDragWidth + aDistance
]

{ #category : #initialization }
ToTableNode >> freezeCellsWidth [

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
ToTableNode >> newRawSkin [ 

	^ ToTableNodeSkin new
]
