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
	cell updateWidthWith: state startDragWidth + aDistance
]

{ #category : #skin }
ToTableNode >> newRawSkin [ 

	^ ToTableNodeSkin new
]

{ #category : #initialization }
ToTableNode >> recordCellsWidth [

	| columns index cells last state |
	columns := self holder listElement columns.
	index := 1.
	cells := self cells.
	cells allButLastDo: [ :cell |
			state := self holder listElement cellStateAt: index.
			cell updateWidthWith: state width.
			index := index + 1 ].
	columns last resizable ifTrue: [ ^ self ].
	last := cells last.
	state := self holder listElement cellStateAt: index.
	last updateWidthWith: state width
]
