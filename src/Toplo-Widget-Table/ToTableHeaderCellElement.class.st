Class {
	#name : #ToTableHeaderCellElement,
	#superclass : #ToTableCellElement,
	#instVars : [
		'innerElement'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #initialization }
ToTableHeaderCellElement class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme when: ToInstallSkinEvent do: [ :cell |
					cell padding: (BlInsets
							 horizontal: (cell valueOfTokenNamed: #'table-cell-padding-H')
							 vertical: (cell valueOfTokenNamed: #'table-header-cell-padding-V')) ] ]
]

{ #category : #initialization }
ToTableHeaderCellElement >> initialize [

	super initialize.
	self id: #headerCell
]

{ #category : #updating }
ToTableHeaderCellElement >> initializeFromColumnInTableElement: aTableElement [

	innerElement := ToTripletElement new.
	innerElement
		hMatchParent;
		vFitContent.
	self addChild: innerElement.
	innerElement middleContainer layout: BlLinearLayout horizontal.
	column buildHeaderCellElement: innerElement middleContainer inTableElement: aTableElement.
	column width
		ifNotNil: [ :w | self width: w ]
		ifNil: [ self hMatchParent ].
	column sorterBlock ifNotNil: [
			| arrow |
			arrow := ToIconicArrowButton new.
			innerElement endElement: arrow.
			innerElement endFlexible: true.
			self updateArrowOrientation: arrow.
			innerElement endElement clickAction: [
					column nextSort.
					self updateArrowOrientation: arrow.
					innerElement endElement fireEvent:
						(ToSortColumn column: column) ] ]
]

{ #category : #updating }
ToTableHeaderCellElement >> updateArrowOrientation: arrow [

	self column sortOrder = #ascending ifTrue: [ ^ arrow beDown ].
	self column sortOrder = #descending ifTrue: [ ^ arrow beUp ].
	^ arrow beRight 
]

{ #category : #accessing }
ToTableHeaderCellElement >> updateWidthWith: aNumber [

	super updateWidthWith: aNumber.

]
