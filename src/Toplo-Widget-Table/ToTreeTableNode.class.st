Class {
	#name : #ToTreeTableNode,
	#superclass : #ToTreeNode,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #accessing }
ToTreeTableNode >> cellContainers [ 

	^ self middleContainer children asArray
]

{ #category : #accessing }
ToTreeTableNode >> cells [ 

	^ self cellContainers collect: [ :cont | cont cell ]
]

{ #category : #accessing }
ToTreeTableNode >> columns [

	^ self holder listElement columns
]

{ #category : #accessing }
ToTreeTableNode >> divider: aDivider movedBy: aDistance from: aStartLocation [

	| container listElement state indent |
	listElement := self holder listElement.
	state := listElement cellStateAt: aDivider cellIndex.
	container := self cellContainers at: aDivider cellIndex.
	indent := aDivider cellIndex = 1
		          ifTrue: [ self indentFiller width ]
		          ifFalse: [ 0 ].
	container updateWidthWith: state startDragWidth + aDistance - indent
]

{ #category : #accessing }
ToTreeTableNode >> indentWidth: aNumber [

	| listElement cont state |
	super indentWidth: aNumber.
	listElement := self holder listElement.

	cont := self cellContainers first.
	state := listElement cellStateAt: 1.
	state width ifNotNil: [ cont updateWidthWith: state width - aNumber ]
]

{ #category : #skin }
ToTreeTableNode >> newRawSkin [ 
	
	^ ToTreeTableNodeSkin new
]

{ #category : #initialization }
ToTreeTableNode >> recordCellsWidth [

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
