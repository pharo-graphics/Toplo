Class {
	#name : #ToTreeTableNode,
	#superclass : #ToTreeNode,
	#traits : 'TToTableNode',
	#classTraits : 'TToTableNode classTrait',
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #accessing }
ToTreeTableNode >> addCellContainer: aCellContainer [

	self addChild: aCellContainer
]

{ #category : #'t - table node' }
ToTreeTableNode >> cellContainers [ 

	^ self children asArray
]

{ #category : #accessing }
ToTreeTableNode >> containerIndentWidth [

	^ self holder nodeContainer indentWidth
]

{ #category : #'t - table node' }
ToTreeTableNode >> divider: aDivider movedBy: aDistance from: aStartLocation [

	| container listElement state indent |
	listElement := self holder listElement.
	state := listElement columnStateAt: aDivider cellIndex.
	container := self cellContainers at: aDivider cellIndex.
	indent := aDivider cellIndex = 1
		          ifTrue: [ self containerIndentWidth ]
		          ifFalse: [ 0 ].
	container updateWidthWith: state startDragWidth + aDistance - indent
]

{ #category : #skin }
ToTreeTableNode >> newRawSkin [ 
	
	^ ToTreeTableNodeSkin new
]
