Class {
	#name : #ToTreeTableListElement,
	#superclass : #ToTreeElement,
	#traits : 'TToCheckableSelectionManager',
	#classTraits : 'TToCheckableSelectionManager classTrait',
	#instVars : [
		'parentTable'
	],
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #accessing }
ToTreeTableListElement >> cellStateAt: anIndex [

	^ (self headerCellAt: anIndex) state
]

{ #category : #accessing }
ToTreeTableListElement >> columns [

	^ self nodeManager columns
]

{ #category : #accessing }
ToTreeTableListElement >> columns: aTableColumnArray [

	self nodeManager columns: aTableColumnArray.
	self onUseCheckboxChangedWith: (aTableColumnArray anySatisfy: [ :col | col useCheckbox ])
]

{ #category : #initialization }
ToTreeTableListElement >> defaultNodeManagerClass [

	^ ToTreeTableNodeManager
]

{ #category : #accessing }
ToTreeTableListElement >> divider: aDivider movedBy: aDistance from: aStartLocation [

	self innerElement nodes do: [ :n |
		n divider: aDivider movedBy: aDistance from: aStartLocation ]
]

{ #category : #initialization }
ToTreeTableListElement >> freezeCellsWidth [

	self innerElement nodesDo: [ :n | n freezeCellsWidth ]
]

{ #category : #accessing }
ToTreeTableListElement >> headerCellAt: anIndex [

	^ parentTable header cells at: anIndex
]

{ #category : #accessing }
ToTreeTableListElement >> parentTable [

	^ parentTable
]

{ #category : #accessing }
ToTreeTableListElement >> parentTable: aTableElement [

	parentTable := aTableElement
]
