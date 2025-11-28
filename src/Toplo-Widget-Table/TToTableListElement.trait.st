Trait {
	#name : #TToTableListElement,
	#instVars : [
		'parentTable'
	],
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'t - table list element' }
TToTableListElement >> columnStateAt: anIndex [

	^ (self headerCellContainerAt: anIndex) state
]

{ #category : #'t - table list element' }
TToTableListElement >> columns [

	^ self nodeManager columns
]

{ #category : #'t - table list element' }
TToTableListElement >> columns: aTableColumnArray [

	self nodeManager columns: aTableColumnArray
]

{ #category : #'t - table list element' }
TToTableListElement >> divider: aDivider movedBy: aDistance from: aStartLocation [

	self innerElement nodeContainersDo: [ :container |
		container node divider: aDivider movedBy: aDistance from: aStartLocation ]
]

{ #category : #'t - table list element' }
TToTableListElement >> headerCellContainerAt: anIndex [

	^ parentTable header cellContainers at: anIndex
]

{ #category : #'t - table list element' }
TToTableListElement >> parentTable [

	^ parentTable
]

{ #category : #'t - table list element' }
TToTableListElement >> parentTable: aTableElement [

	parentTable := aTableElement
]

{ #category : #'t - table list element' }
TToTableListElement >> recordCellsWidth [

	self innerElement nodeContainersDo: [ :container | container node recordCellsWidth ]
]
