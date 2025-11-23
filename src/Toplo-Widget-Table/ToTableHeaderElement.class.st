"
I represent how header should be render. The disposition should be similar to what List have (for the size of the columns)
"
Class {
	#name : #ToTableHeaderElement,
	#superclass : #ToElement,
	#instVars : [
		'parentTable'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #initialization }
ToTableHeaderElement class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme when: ToInstallSkinEvent do: [ :header |
					header padding: (BlInsets
							 horizontal: (header valueOfTokenNamed: #'list-padding-H')
							 vertical: (header valueOfTokenNamed: #'list-padding-V')) ] ]
]

{ #category : #accessing }
ToTableHeaderElement >> cells [

	^ self selectChildrenWithId: #headerCell
]

{ #category : #accessing }
ToTableHeaderElement >> columns: aTableColumnArray [

	self removeCells.
	aTableColumnArray do: [ :column |
			| cell |
			cell := self newCellInColumn: column.
			self addChild: cell ]
]

{ #category : #initialization }
ToTableHeaderElement >> defaultLayout [ 

	" don't use vertical or horizontal to allow vertical centering of children "
	^ BlLinearLayout new
]

{ #category : #accessing }
ToTableHeaderElement >> divider: aDivider movedBy: aDistance from: aStartLocation [

	|  cell |
	cell := self cells at: aDivider cellIndex.
	cell updateWidthWith: cell state startDragWidth + aDistance
]

{ #category : #accessing }
ToTableHeaderElement >> divider: aDivider startDragAt: aDistance [

	|  cell |
	cell := self cells at: aDivider cellIndex.
	cell state startDragWidth: cell width
]

{ #category : #initialization }
ToTableHeaderElement >> initialize [

	super initialize.
	self vFitContent.
	self hMatchParent.
	self addEventHandler: ToTableHeaderElementEventHandler new
]

{ #category : #initialization }
ToTableHeaderElement >> newCellInColumn: aColumn [

	^ ToTableHeaderCellElement new
		  column: aColumn;
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  initializeFromColumnInTableElement: parentTable;
		  yourself
]

{ #category : #accessing }
ToTableHeaderElement >> parentTable [

	^ parentTable
]

{ #category : #accessing }
ToTableHeaderElement >> parentTable: aTableElement [

	parentTable := aTableElement
]

{ #category : #initialization }
ToTableHeaderElement >> recordCellsWidth [

	| last |
	self cells allButLastDo: [ :e | e updateWidthWith: e width ].
	last := self cells last.
	last column resizable ifTrue: [ ^ self ].
	last updateWidthWith: last width
]

{ #category : #accessing }
ToTableHeaderElement >> removeCells [

	self cells do: [ :c | c removeFromParent ]
]
