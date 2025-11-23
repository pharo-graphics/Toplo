Class {
	#name : #ToTableHeaderCellContainer,
	#superclass : #ToTableCellContainer,
	#instVars : [
		'state'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #'instance creation' }
ToTableHeaderCellContainer class >> column: aColumn [

	^ self basicNew
		  column: aColumn;
		  initialize;
		  yourself
]

{ #category : #initialization }
ToTableHeaderCellContainer class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme when: ToInstallSkinEvent do: [ :cell |
					cell
						addTokenNamed: #'font-weight-attribute'
						withValue: BlFontWeightAttribute bold.
					cell padding: (BlInsets
							 horizontal: (cell valueOfTokenNamed: #'table-cell-padding-H')
							 vertical:
							 (cell valueOfTokenNamed: #'table-header-cell-padding-V')) ] ]
]

{ #category : #accessing }
ToTableHeaderCellContainer >> column: aTableColumn [

	super column: aTableColumn.
	self initializeState
]

{ #category : #initialization }
ToTableHeaderCellContainer >> initialize [

	super initialize.
	self id: #headerCellContainer
]

{ #category : #updating }
ToTableHeaderCellContainer >> initializeFromColumnInTableElement: aTableElement [

	column
		buildHeaderCellInContainer: self
		inTableElement: aTableElement.
	column width
		ifNotNil: [ :w | self width: w ]
		ifNil: [ self hMatchParent ].
	column sorterBlock ifNotNil: [
			| arrow |
			arrow := ToIconicArrowButton new.
			self endContainer addChild: arrow.
			self endFlexible: true.
			self updateArrowOrientation: arrow.
			arrow clickAction: [
					column nextSort.
					self updateArrowOrientation: arrow.
					aTableElement header dispatchEvent: (ToColumnSortRequestEvent column: column) ] ]
]

{ #category : #initialization }
ToTableHeaderCellContainer >> initializeState [

	self state initializeFromColumn: column
]

{ #category : #'t - triplet container - instance creation' }
ToTableHeaderCellContainer >> newMiddleContainer [ 

	^ column headerCellFactory value
]

{ #category : #accessing }
ToTableHeaderCellContainer >> state [

	^ state ifNil: [ state := self newColumnState ]
]

{ #category : #updating }
ToTableHeaderCellContainer >> updateArrowOrientation: arrow [

	self column sortOrder = #ascending ifTrue: [ ^ arrow beDown ].
	self column sortOrder = #descending ifTrue: [ ^ arrow beUp ].
	^ arrow beRight 
]

{ #category : #accessing }
ToTableHeaderCellContainer >> updateWidthWith: aNumber [

	state width: aNumber.
	super updateWidthWith: aNumber.

]
