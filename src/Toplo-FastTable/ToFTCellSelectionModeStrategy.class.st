"
Description
--------------------

I am a strategy to manage the behaviour of a ToFTTableMorph in case we are in a cell selection mode.

My indexes are stored as tuples whose first element designate the selected row and second element the selected column.

Examples
--------------------

	ToFTCellSelectionModeStrategy table: aToFTTableMorph
"
Class {
	#name : #ToFTCellSelectionModeStrategy,
	#superclass : #ToFTSelectionModeStrategy,
	#category : #'Toplo-FastTable-Selection'
}

{ #category : #testing }
ToFTCellSelectionModeStrategy >> allowsCellSelection [
	^ true
]

{ #category : #accessing }
ToFTCellSelectionModeStrategy >> indexForRow: aRowIndex [
	^ {aRowIndex . self table selectedIndex second}
]

{ #category : #accessing }
ToFTCellSelectionModeStrategy >> indexFromPosition: aTuple [
	^ aTuple
]

{ #category : #accessing }
ToFTCellSelectionModeStrategy >> indexesToSelectInMultipleSelectionFrom: firstIndex to: endIndex [
	| stepV stepH |
	stepV := firstIndex first <= endIndex first ifTrue: [ 1 ] ifFalse: [ -1 ].
	stepH := firstIndex second <= endIndex second ifTrue: [ 1 ] ifFalse: [ -1 ].
	^ (firstIndex second to: endIndex second by: stepH) flatCollect: [ :v | (firstIndex first to: endIndex first by: stepV) collect: [ :h | {h . v} ] ]
]

{ #category : #testing }
ToFTCellSelectionModeStrategy >> is: anIndex aboveRow: aRowIndex [
	^ anIndex first < aRowIndex
]

{ #category : #testing }
ToFTCellSelectionModeStrategy >> is: anIndex afterColumn: aColumnIndex [
	^ anIndex second > aColumnIndex
]

{ #category : #testing }
ToFTCellSelectionModeStrategy >> is: anIndex beforeColumn: aColumnIndex [
	^ anIndex second < aColumnIndex
]

{ #category : #testing }
ToFTCellSelectionModeStrategy >> is: anIndex bellowRow: aRowIndex [
	^ anIndex first > aRowIndex
]

{ #category : #accessing }
ToFTCellSelectionModeStrategy >> nullIndex [
	^ #(0 0)
]

{ #category : #accessing }
ToFTCellSelectionModeStrategy >> rowIndexFrom: anIndex [
	^ anIndex first
]

{ #category : #selection }
ToFTCellSelectionModeStrategy >> selectAll [
	self table selectIndexes: ((1 to: self table numberOfRows) flatCollect: [ :rowIndex | (1 to: self table numberOfColumns) collect: [ :columnIndex | {rowIndex . columnIndex} ] ]) asArray
]

{ #category : #selection }
ToFTCellSelectionModeStrategy >> selectFirst [
	self table selectIndex: #(1 1)
]

{ #category : #selection }
ToFTCellSelectionModeStrategy >> selectLast [
	self table selectIndex: {self table numberOfRows . self table numberOfColumns}
]

{ #category : #accessing }
ToFTCellSelectionModeStrategy >> selectableIndexAbove: anIndex [
	^ {(anIndex first - 1) . anIndex second}
]

{ #category : #accessing }
ToFTCellSelectionModeStrategy >> selectableIndexAfter: anIndex [
	^ {anIndex first . (anIndex second + 1)}
]

{ #category : #accessing }
ToFTCellSelectionModeStrategy >> selectableIndexBefore: anIndex [
	^ {anIndex first . (anIndex second - 1)}
]

{ #category : #accessing }
ToFTCellSelectionModeStrategy >> selectableIndexBellow: anIndex [
	^ {(anIndex first + 1) . anIndex second}
]

{ #category : #accessing }
ToFTCellSelectionModeStrategy >> selectableIndexContainingPoint: aPoint [
	^ self tableContainer rowAndColumnIndexContainingPoint: aPoint
]

{ #category : #adding }
ToFTCellSelectionModeStrategy >> selectablesToHighlightFromRow: aToFTRow at: aRowIndex withHighlightedIndexes: highligtedIndexes andPrimaryIndex: primarySelectionIndex [
	| selectablesToColorMap |
	selectablesToColorMap := Dictionary new.
	self flag: #pharoFixMe.	"Currently, the rows in FastTable have cells in submorphs, but the API should be improved to provide better cell iterations instead of letting external users touch row submorphs."
	aToFTRow submorphs
		withIndexDo: [ :each :columnIndex |
			| cellIndex |
			(highligtedIndexes includes: (cellIndex := {aRowIndex . columnIndex})) ifTrue: [ selectablesToColorMap at: each put: primarySelectionIndex = cellIndex ] ].
	^ selectablesToColorMap
]
