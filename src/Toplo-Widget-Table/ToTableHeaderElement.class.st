Class {
	#name : #ToTableHeaderElement,
	#superclass : #ToElement,
	#instVars : [
		'parentTable',
		'nodeContainer'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #accessing }
ToTableHeaderElement >> cellContainerAt: anIndex [

	^ nodeContainer cellContainerAt: anIndex
]

{ #category : #accessing }
ToTableHeaderElement >> cellContainers [

	^ self nodeContainer cellContainers
]

{ #category : #initialization }
ToTableHeaderElement >> cleanUp [ 

	nodeContainer cleanUp
]

{ #category : #accessing }
ToTableHeaderElement >> columnStateAt: anIndex [

	^ (self cellContainerAt: anIndex) state
]

{ #category : #initialization }
ToTableHeaderElement >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #'t - table list element' }
ToTableHeaderElement >> divider: aDivider movedBy: aDistance from: aStartLocation [

	nodeContainer divider: aDivider movedBy: aDistance from: aStartLocation.
]

{ #category : #accessing }
ToTableHeaderElement >> divider: aDivider startDragAt: aPosition [

	nodeContainer divider: aDivider startDragAt: aPosition
]

{ #category : #initialization }
ToTableHeaderElement >> initialize [ 

	super initialize.
	self hMatchParent.
	self vFitContent
]

{ #category : #initialization }
ToTableHeaderElement >> initializeDividers [

	| containers index |
	parentTable removeDividers.
	containers := self cellContainers.
	index := 0.
	containers overlappingPairsDo: [ :first :second |
			| col |
			index := index + 1.
			col := first column.
			col resizable ifTrue: [
				parentTable addDivider: parentTable newDivider atIndex: index ] ].
	parentTable requestDividersUpdate
]

{ #category : #accessing }
ToTableHeaderElement >> initializeWithColumns: aTableColumnArray [

	self cleanUp.
	nodeContainer initializeWithColumns: aTableColumnArray
]

{ #category : #accessing }
ToTableHeaderElement >> newHeaderNodeContainer [

	^ ToTableHeaderRowNodeContainer new
]

{ #category : #accessing }
ToTableHeaderElement >> nodeContainer [ 

	^ nodeContainer
]

{ #category : #accessing }
ToTableHeaderElement >> parentTable [

	^ parentTable
]

{ #category : #accessing }
ToTableHeaderElement >> parentTable: aTableElement [

	parentTable := aTableElement.
	nodeContainer := self newHeaderNodeContainer
		                 parentTable: parentTable;
		                 yourself.
	self addChild: nodeContainer.


]

{ #category : #'t - table list element' }
ToTableHeaderElement >> recordCellsWidth [ 

	nodeContainer recordCellsWidth
]

{ #category : #accessing }
ToTableHeaderElement >> useCheckbox: aBoolean [

	nodeContainer useCheckbox: aBoolean
]
