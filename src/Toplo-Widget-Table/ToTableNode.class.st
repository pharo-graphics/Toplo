Class {
	#name : #ToTableNode,
	#superclass : #ToListNode,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #accessing }
ToTableNode >> columns [

	^ self holder listElement columns
]

{ #category : #accessing }
ToTableNode >> dividerAt: anIndex movedBy: aDistance from: aStartLocation [

	| elements first column |
	column := self holder listElement columns at: anIndex.
	elements := self children.
	first := self childAt: anIndex.
	first width: column startDragWidth + aDistance
]

{ #category : #initialization }
ToTableNode >> freezeColumnsWidth [

	| columns index columnElements last |
	columns := self holder listElement columns.
	index := 1.
	columnElements := self children asArray.
	columnElements allButLastDo: [ :child |
			| col |
			col := columns at: index.
			child constraints horizontal exact: child width.
			index := index + 1 ].
	columns last resizable ifTrue: [ ^ self ].
	last := columnElements last.
	last constraints horizontal exact: last width
]

{ #category : #skin }
ToTableNode >> newRawSkin [ 

	^ ToTableNodeSkin new
]
