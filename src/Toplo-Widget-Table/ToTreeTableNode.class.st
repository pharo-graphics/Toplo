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

	| cell listElement state indent |
	listElement := self holder listElement.
	state := listElement cellStateAt: aDivider cellIndex.
	cell := self cells at: aDivider cellIndex.
	indent := aDivider cellIndex = 1
		          ifTrue: [ self indentFiller width ]
		          ifFalse: [ 0 ].
	cell updateWidthWith: state startDragWidth + aDistance - indent
]

{ #category : #initialization }
ToTreeTableNode >> freezeCellsWidth [

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

{ #category : #accessing }
ToTreeTableNode >> indentWidth: aNumber [

	| listElement cell state |
	super indentWidth: aNumber.
	listElement := self holder listElement.

	cell := self cells first.
	state := listElement cellStateAt: 1.
	state width ifNotNil: [ cell updateWidthWith: state width - aNumber ]
]

{ #category : #skin }
ToTreeTableNode >> newRawSkin [ 
	
	^ ToTreeTableNodeSkin new
]
