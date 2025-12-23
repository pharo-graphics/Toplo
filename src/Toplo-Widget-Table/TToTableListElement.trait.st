Trait {
	#name : #TToTableListElement,
	#instVars : [
		'parentTable'
	],
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #accessing }
TToTableListElement classSide >> parentTable: aTableElement [

	^ self basicNew
		  parentTable: aTableElement;
		  initialize;
		  yourself
]

{ #category : #'t - table list element' }
TToTableListElement >> columnStateAt: anIndex [

	^ parentTable columnStateAt: anIndex
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
