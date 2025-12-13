Class {
	#name : #ToTableHeaderElement,
	#superclass : #ToElement,
	#instVars : [
		'parentTable',
		'nodeContainer',
		'ruler'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #accessing }
ToTableHeaderElement >> cellContainerAt: anIndex [

	^ nodeContainer cellContainerAt: anIndex
]

{ #category : #initialization }
ToTableHeaderElement >> cleanUp [ 

	ruler cleanUp.
	nodeContainer cleanUp
]

{ #category : #accessing }
ToTableHeaderElement >> columnStateAt: anIndex [

	^ ruler columnStateAt: anIndex
]

{ #category : #initialization }
ToTableHeaderElement >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #'t - table list element' }
ToTableHeaderElement >> divider: aDivider movedBy: aDistance from: aStartLocation [

	ruler divider: aDivider movedBy: aDistance from: aStartLocation.
	nodeContainer divider: aDivider movedBy: aDistance from: aStartLocation.
]

{ #category : #accessing }
ToTableHeaderElement >> divider: aDivider startDragAt: aPosition [

	ruler divider: aDivider startDragAt: aPosition
]

{ #category : #initialization }
ToTableHeaderElement >> initialize [ 

	super initialize.
	self hMatchParent.
	self vFitContent
]

{ #category : #initialization }
ToTableHeaderElement >> initializeDividers [

	ruler initializeDividers
]

{ #category : #accessing }
ToTableHeaderElement >> initializeWithColumns: aTableColumnArray [

	self cleanUp.
	ruler initializeWithColumns: aTableColumnArray.
	nodeContainer initializeWithColumns: aTableColumnArray
]

{ #category : #accessing }
ToTableHeaderElement >> newHeaderColumnsRuler [

	^ ToTableHeaderRulerNodeContainer new
]

{ #category : #accessing }
ToTableHeaderElement >> newHeaderNodeContainer [

	^ ToTableHeaderNodeContainer new
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
	ruler := self newHeaderColumnsRuler
		                parentTable: parentTable;
		                yourself.
	nodeContainer := self newHeaderNodeContainer
		                 parentTable: parentTable;
		                 yourself.
	self addChild: ruler.
	self addChild: nodeContainer.


]

{ #category : #'t - table list element' }
ToTableHeaderElement >> recordCellsWidth [ 

	ruler recordCellsWidth.
	nodeContainer recordCellsWidth
]

{ #category : #accessing }
ToTableHeaderElement >> rulerCellAt: anIndex [

	^ ruler rulerCellAt: anIndex
]

{ #category : #accessing }
ToTableHeaderElement >> rulerCells [ 

	^ ruler rulerCells
]

{ #category : #accessing }
ToTableHeaderElement >> useCheckbox: aBoolean [

	ruler useCheckbox: aBoolean.
	nodeContainer useCheckbox: aBoolean
]
