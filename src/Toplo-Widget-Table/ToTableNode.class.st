Class {
	#name : #ToTableNode,
	#superclass : #ToListNode,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #accessing }
ToTableNode >> cellContainers [

	^ self children asArray 
]

{ #category : #accessing }
ToTableNode >> cells [ 

	^ self cellContainers collect: [ :cont | cont cell ]
]

{ #category : #accessing }
ToTableNode >> columns [

	^ self holder listElement columns
]

{ #category : #accessing }
ToTableNode >> divider: aDivider movedBy: aDistance from: aStartLocation [

	| container listElement state |
	listElement := self holder listElement.
	state := listElement cellStateAt: aDivider cellIndex.
	container := self cellContainers at: aDivider cellIndex.
	container updateWidthWith: state startDragWidth + aDistance
]

{ #category : #skin }
ToTableNode >> newRawSkin [ 

	^ ToTableNodeSkin new
]

{ #category : #initialization }
ToTableNode >> recordCellsWidth [

	| columns index containers last state |
	columns := self holder listElement columns.
	index := 1.
	containers := self cellContainers.
	containers allButLastDo: [ :cont |
			state := self holder listElement cellStateAt: index.
			cont updateWidthWith: state width.
			index := index + 1 ].
	columns last resizable ifTrue: [ ^ self ].
	last := containers last.
	state := self holder listElement cellStateAt: index.
	last updateWidthWith: state width
]
