Class {
	#name : #ToTreeTableRowNode,
	#superclass : #ToTreeNode,
	#traits : 'TToTableRowNode',
	#classTraits : 'TToTableRowNode classTrait',
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #accessing }
ToTreeTableRowNode >> addCellContainer: aCellContainer [

	self addChild: aCellContainer
]

{ #category : #'t - table node' }
ToTreeTableRowNode >> cellContainers [ 

	^ self children asArray
]

{ #category : #accessing }
ToTreeTableRowNode >> containerIndentWidth [

	^ self holder nodeContainer indentWidth
]

{ #category : #'t - table node' }
ToTreeTableRowNode >> divider: aDivider movedBy: aDistance from: aStartLocation [

	| container listElement state indent column minWidth |
	listElement := self holder listElement.
	state := listElement columnStateAt: aDivider cellIndex.
	container := self cellContainers at: aDivider cellIndex.
	column := listElement columns at: aDivider cellIndex.
	minWidth := column minWidth.
	indent := aDivider cellIndex = 1
		          ifTrue: [ self containerIndentWidth ]
		          ifFalse: [ 0 ].
	container updateWidthWith:
		(state startDragWidth + aDistance - indent max: minWidth)
]

{ #category : #skin }
ToTreeTableRowNode >> newRawSkin [ 
	
	" have to define a new skin to not use the inherited one "
	^ ToTreeTableRowNodeSkin new
]
