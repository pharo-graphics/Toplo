"
I represent how header should be render. The disposition should be similar to what List have (for the size of the columns)
"
Class {
	#name : #ToTableHeaderNodeContainer,
	#superclass : #ToTripletContainer,
	#instVars : [
		'parentTable',
		'checkbox'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #initialization }
ToTableHeaderNodeContainer class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #padding)
				with: [ :e |
						BlInsets empty
							"horizontal: (e valueOfTokenNamed: #'list-padding-H')
							vertical: (e valueOfTokenNamed: #'list-padding-V') "] ]
]

{ #category : #accessing }
ToTableHeaderNodeContainer >> addCheckbox [

	checkbox ifNotNil: [ ^ self ].
	checkbox := parentTable newHeaderCheckbox.
	checkbox constraintsDo: [ :c | c linear vertical alignCenter ].
	self ensureStartContainer.
	self startContainer addChild: checkbox
]

{ #category : #accessing }
ToTableHeaderNodeContainer >> cellContainerAt: anIndex [

	^ self node cellContainerAt: anIndex
]

{ #category : #accessing }
ToTableHeaderNodeContainer >> cellContainers [

	^ self node cellContainers
]

{ #category : #initialization }
ToTableHeaderNodeContainer >> cleanUp [ 

	self removeCheckbox.
	self middleContainer removeChildren
	
]

{ #category : #accessing }
ToTableHeaderNodeContainer >> columns [ 

	^ parentTable columns
]

{ #category : #accessing }
ToTableHeaderNodeContainer >> divider: aDivider movedBy: aDistance from: aStartLocation [

	|  cont minWidth column colElement |
	colElement := self rulerCells at: aDivider cellIndex.
	cont := self cellContainers at: aDivider cellIndex.
	column := colElement column.
	minWidth := column minWidth.
	cont updateWidthWith: ((colElement state startDragWidth + aDistance) max: minWidth)
]

{ #category : #accessing }
ToTableHeaderNodeContainer >> divider: aDivider startDragAt: aDistance [

	|  cont |
	cont := self cellContainers at: aDivider cellIndex.
	cont state startDragWidth: cont width
]

{ #category : #initialization }
ToTableHeaderNodeContainer >> initialize [

	super initialize.
	self createMiddleContainer.
	self vFitContent.
	self hMatchParent
]

{ #category : #accessing }
ToTableHeaderNodeContainer >> initializeWithColumns: aTableColumnArray [
	
	aTableColumnArray do: [ :column |
			| cellContainer |
			cellContainer := self newCellContainerInColumn: column.
			self middleContainer addChild: cellContainer ]
]

{ #category : #initialization }
ToTableHeaderNodeContainer >> newCellContainerInColumn: aColumn [

	^ (ToTableHeaderCellContainer column: aColumn)
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  initializeFromColumnInTableElement: parentTable;
		  yourself
]

{ #category : #'t - triplet container - instance creation' }
ToTableHeaderNodeContainer >> newMiddleContainer [

	^ ToTableHeaderNode new
]

{ #category : #'instance creation' }
ToTableHeaderNodeContainer >> newRawSkin [ 

	^ ToTableHeaderElementSkin new
]

{ #category : #accessing }
ToTableHeaderNodeContainer >> node [

	^ self middleContainer 
]

{ #category : #accessing }
ToTableHeaderNodeContainer >> parentTable [

	^ parentTable
]

{ #category : #accessing }
ToTableHeaderNodeContainer >> parentTable: aTableElement [

	parentTable := aTableElement
]

{ #category : #initialization }
ToTableHeaderNodeContainer >> recordCellsWidth [

	| last |
	self cellContainers allButLastDo: [ :e | e updateWidthWith: e width ].
	last := self cellContainers last.
	last column resizable ifTrue: [ ^ self ].
	last updateWidthWith: last width
]

{ #category : #accessing }
ToTableHeaderNodeContainer >> removeCellContainers [

	self cellContainers do: [ :c | c removeFromParent ]
]

{ #category : #accessing }
ToTableHeaderNodeContainer >> removeCheckbox [

	checkbox ifNil: [ ^ self ].
	checkbox removeFromParent
]

{ #category : #accessing }
ToTableHeaderNodeContainer >> rulerCells [

	^ parentTable header rulerCells
]

{ #category : #accessing }
ToTableHeaderNodeContainer >> useCheckbox: aBoolean [

	aBoolean
		ifTrue: [ self addCheckbox ]
		ifFalse: [ self removeCheckbox ].
	self requestNewSkin
]
