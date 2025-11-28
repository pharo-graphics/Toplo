Class {
	#name : #ToTableHeaderCellElement,
	#superclass : #ToTableCellElement,
	#instVars : [
		'state'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #initialization }
ToTableHeaderCellElement class >> initializeToRawTheme: aTheme [
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

{ #category : #initialization }
ToTableHeaderCellElement >> initialize [

	super initialize.
	self id: #headerCell.
	state := self newColumnState.
]

{ #category : #updating }
ToTableHeaderCellElement >> initializeFromColumnInTableElement: aTableElement [

	column
		buildHeaderCellElement: self
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
