Class {
	#name : #ToTreeTableNode,
	#superclass : #ToTreeNode,
	#traits : 'TToTableNode',
	#classTraits : 'TToTableNode classTrait',
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #accessing }
ToTreeTableNode >> addCellContainer: aCellContainer [

	self   addChild: aCellContainer
]

{ #category : #'t - table node' }
ToTreeTableNode >> cellContainers [ 

	^ self children asArray
]

{ #category : #'t - table node' }
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
