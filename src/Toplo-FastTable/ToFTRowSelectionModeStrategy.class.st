"
Description
--------------------

I am a strategy to manage the behaviour of a ToFTTableMorph in case we are in a row selection mode.

My indexes are integers defining the index of the selected row.

Examples
--------------------

	ToFTRowSelectionModeStrategy table: aToFTTableMorph
"
Class {
	#name : #ToFTRowSelectionModeStrategy,
	#superclass : #ToFTSelectionModeStrategy,
	#category : #'Toplo-FastTable-Selection'
}

{ #category : #testing }
ToFTRowSelectionModeStrategy >> allowsRowSelection [
	^ true
]

{ #category : #accessing }
ToFTRowSelectionModeStrategy >> indexForRow: aRowIndex [
	^ aRowIndex
]

{ #category : #accessing }
ToFTRowSelectionModeStrategy >> indexFromPosition: aTuple [
	^ aTuple first
]

{ #category : #accessing }
ToFTRowSelectionModeStrategy >> indexesToSelectInMultipleSelectionFrom: firstIndex to: endIndex [
	| step |
	step := firstIndex <= endIndex ifTrue: [ 1 ] ifFalse: [ -1 ].
	^ firstIndex to: endIndex by: step
]

{ #category : #testing }
ToFTRowSelectionModeStrategy >> is: anIndex aboveRow: aRowIndex [
	^ anIndex < aRowIndex
]

{ #category : #testing }
ToFTRowSelectionModeStrategy >> is: anIndex afterColumn: aColumnIndex [
	"A row cannot be before or after a column."

	^ false
]

{ #category : #testing }
ToFTRowSelectionModeStrategy >> is: anIndex beforeColumn: aColumn [
	"A row cannot be before or after a column."

	^ false
]

{ #category : #testing }
ToFTRowSelectionModeStrategy >> is: anIndex bellowRow: aRowIndex [
	^ anIndex > aRowIndex
]

{ #category : #accessing }
ToFTRowSelectionModeStrategy >> nullIndex [
	^ 0
]

{ #category : #accessing }
ToFTRowSelectionModeStrategy >> rowIndexFrom: anIndex [
	^ anIndex
]

{ #category : #selection }
ToFTRowSelectionModeStrategy >> selectAll [
	self table selectIndexes: (1 to: self table numberOfRows) asArray
]

{ #category : #selection }
ToFTRowSelectionModeStrategy >> selectFirst [
	self table selectIndex: 1
]

{ #category : #selection }
ToFTRowSelectionModeStrategy >> selectLast [
	self table selectIndex: self table numberOfRows
]

{ #category : #accessing }
ToFTRowSelectionModeStrategy >> selectableIndexAbove: anIndex [
	^ anIndex - 1
]

{ #category : #accessing }
ToFTRowSelectionModeStrategy >> selectableIndexAfter: anIndex [
	"Because rows cannot have something at the right or left."

	self shouldNotImplement
]

{ #category : #accessing }
ToFTRowSelectionModeStrategy >> selectableIndexBefore: anIndex [
	"Because rows cannot have something at the right or left."

	self shouldNotImplement
]

{ #category : #accessing }
ToFTRowSelectionModeStrategy >> selectableIndexBellow: anIndex [
	^ anIndex + 1
]

{ #category : #accessing }
ToFTRowSelectionModeStrategy >> selectableIndexContainingPoint: aPoint [
	^ self tableContainer rowIndexContainingPoint: aPoint
]

{ #category : #adding }
ToFTRowSelectionModeStrategy >> selectablesToHighlightFromRow: aToFTRow at: aRowIndex withHighlightedIndexes: highligtedIndexes andPrimaryIndex: primarySelectionIndex [
	| selectablesToColorMap |
	selectablesToColorMap := Dictionary new.
	(highligtedIndexes includes: aRowIndex) ifTrue: [ selectablesToColorMap at: aToFTRow put: primarySelectionIndex = aRowIndex ].
	^ selectablesToColorMap
]
