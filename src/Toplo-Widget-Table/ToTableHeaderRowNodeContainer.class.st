"
I represent how header should be render. The disposition should be similar to what List have (for the size of the columns)
"
Class {
	#name : #ToTableHeaderRowNodeContainer,
	#superclass : #ToTripletContainer,
	#instVars : [
		'parentTable',
		'checkbox'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #accessing }
ToTableHeaderRowNodeContainer >> addCheckbox [

	checkbox ifNotNil: [ ^ self ].
	checkbox := parentTable newHeaderCheckbox.
	checkbox constraintsDo: [ :c | c linear vertical alignCenter ].
	self ensureStartContainer.
	self startContainer addChild: checkbox
]

{ #category : #accessing }
ToTableHeaderRowNodeContainer >> cellContainerAt: anIndex [

	^ self node cellContainerAt: anIndex
]

{ #category : #accessing }
ToTableHeaderRowNodeContainer >> cellContainers [

	^ self node cellContainers
]

{ #category : #initialization }
ToTableHeaderRowNodeContainer >> cleanUp [ 

	self removeCheckbox.
	self middleContainer removeChildren
	
]

{ #category : #accessing }
ToTableHeaderRowNodeContainer >> columns [ 

	^ parentTable columns
]

{ #category : #accessing }
ToTableHeaderRowNodeContainer >> divider: aDivider movedBy: aDistance from: aStartLocation [

	|  cont minWidth column colElement |
	colElement := self rulerCells at: aDivider cellIndex.
	cont := self cellContainers at: aDivider cellIndex.
	column := colElement column.
	minWidth := column minWidth.
	cont updateWidthWith: ((colElement state startDragWidth + aDistance) max: minWidth)
]

{ #category : #accessing }
ToTableHeaderRowNodeContainer >> divider: aDivider startDragAt: aDistance [

	|  cont |
	cont := self cellContainers at: aDivider cellIndex.
	cont state startDragWidth: cont width
]

{ #category : #initialization }
ToTableHeaderRowNodeContainer >> initialize [

	super initialize.
	self createMiddleContainer.
	self vFitContent.
	self hMatchParent
]

{ #category : #accessing }
ToTableHeaderRowNodeContainer >> initializeWithColumns: aTableColumnArray [
	
	aTableColumnArray do: [ :column |
			| cellContainer |
			cellContainer := self newCellContainerInColumn: column.
			self middleContainer addChild: cellContainer ]
]

{ #category : #skin }
ToTableHeaderRowNodeContainer >> installRawStyle [ 

	super installRawStyle.
	self padding: (BlInsets horizontal: (self valueOfTokenNamed: #'list-padding-H'))
	
]

{ #category : #initialization }
ToTableHeaderRowNodeContainer >> newCellContainerInColumn: aColumn [

	^ (ToTableHeaderCellContainer column: aColumn)
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  initializeFromColumnInTableElement: parentTable;
		  yourself
]

{ #category : #'t - triplet container - instance creation' }
ToTableHeaderRowNodeContainer >> newMiddleContainer [

	^ ToTableHeaderRowNode new
]

{ #category : #accessing }
ToTableHeaderRowNodeContainer >> node [

	^ self middleContainer 
]

{ #category : #accessing }
ToTableHeaderRowNodeContainer >> parentTable [

	^ parentTable
]

{ #category : #accessing }
ToTableHeaderRowNodeContainer >> parentTable: aTableElement [

	parentTable := aTableElement
]

{ #category : #initialization }
ToTableHeaderRowNodeContainer >> recordCellsWidth [

	| last |
	self cellContainers allButLastDo: [ :e | e updateWidthWith: e width ].
	last := self cellContainers last.
	last column resizable ifTrue: [ ^ self ].
	last updateWidthWith: last width
]

{ #category : #accessing }
ToTableHeaderRowNodeContainer >> removeCellContainers [

	self cellContainers do: [ :c | c removeFromParent ]
]

{ #category : #accessing }
ToTableHeaderRowNodeContainer >> removeCheckbox [

	checkbox ifNil: [ ^ self ].
	checkbox removeFromParent
]

{ #category : #accessing }
ToTableHeaderRowNodeContainer >> rulerCells [

	^ parentTable header rulerCells
]

{ #category : #accessing }
ToTableHeaderRowNodeContainer >> useCheckbox: aBoolean [

	aBoolean
		ifTrue: [ self addCheckbox ]
		ifFalse: [ self removeCheckbox ].
	self requestNewSkin
]
