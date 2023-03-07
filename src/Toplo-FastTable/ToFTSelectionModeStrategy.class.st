"
Description
--------------------


I manage the different selection modes of a FastTable.

I manage the different behaviours between row and cell selections. Maybe we could also add column selection later.

I am part of a Strategy design pattern and I am used by a ToFTTableMroph.

Examples
--------------------

	ToFTCellSelectionModeStrategy table: aToFTTableMorph
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	table:		<aToFTTableMorph>		The fast table whose selection I manage.

"
Class {
	#name : #ToFTSelectionModeStrategy,
	#superclass : #Object,
	#instVars : [
		'table'
	],
	#category : #'Toplo-FastTable-Selection'
}

{ #category : #'instance creation' }
ToFTSelectionModeStrategy class >> table: aTable [
	^ self new
		table: aTable;
		yourself
]

{ #category : #testing }
ToFTSelectionModeStrategy >> allowsCellSelection [
	^ false
]

{ #category : #testing }
ToFTSelectionModeStrategy >> allowsRowSelection [
	^ false
]

{ #category : #accessing }
ToFTSelectionModeStrategy >> indexForRow: aRowIndex [
	^ self subclassResponsibility
]

{ #category : #accessing }
ToFTSelectionModeStrategy >> indexFromPosition: aTuple [
	"I receive a tuple representing a row and a column index in my table and I should return the index of the selectable element that can be selected at this position."

	^ self subclassResponsibility
]

{ #category : #accessing }
ToFTSelectionModeStrategy >> indexesToSelectInMultipleSelectionFrom: firstIndex to: endIndex [
	"In case of multiple selection, I wust return the list of indexes to select when the user uses shift + click."

	^ self subclassResponsibility
]

{ #category : #testing }
ToFTSelectionModeStrategy >> is: anIndex aboveRow: aRowIndex [
	^ self subclassResponsibility
]

{ #category : #testing }
ToFTSelectionModeStrategy >> is: anIndex afterColumn: aColumnIndex [
	^ self subclassResponsibility
]

{ #category : #testing }
ToFTSelectionModeStrategy >> is: anIndex beforeColumn: aColumn [
	^ self subclassResponsibility
]

{ #category : #testing }
ToFTSelectionModeStrategy >> is: anIndex bellowRow: aRowIndex [
	^ self subclassResponsibility
]

{ #category : #accessing }
ToFTSelectionModeStrategy >> nullIndex [
	^ self subclassResponsibility
]

{ #category : #accessing }
ToFTSelectionModeStrategy >> rowIndexFrom: anIndex [
	"From the index of the selectable I should return the row index."

	^ self subclassResponsibility
]

{ #category : #selection }
ToFTSelectionModeStrategy >> selectAll [
	"This method should select all elements of the table."

	self subclassResponsibility
]

{ #category : #selection }
ToFTSelectionModeStrategy >> selectFirst [
	"This method should select the first element of the table."

	self subclassResponsibility
]

{ #category : #selection }
ToFTSelectionModeStrategy >> selectLast [
	"This method should select the first element of the table."

	self subclassResponsibility
]

{ #category : #accessing }
ToFTSelectionModeStrategy >> selectableIndexAbove: anIndex [
	"When getting in this method we should already know there is a selectable above this one."

	^ self subclassResponsibility
]

{ #category : #accessing }
ToFTSelectionModeStrategy >> selectableIndexAfter: anIndex [
	"When getting in this method we should already know there is a selectable after this one."

	^ self subclassResponsibility
]

{ #category : #accessing }
ToFTSelectionModeStrategy >> selectableIndexBefore: anIndex [
	"When getting in this method we should already know there is a selectable before this one."

	^ self subclassResponsibility
]

{ #category : #accessing }
ToFTSelectionModeStrategy >> selectableIndexBellow: anIndex [
	"When getting in this method we should already know there is a selectable before this one."

	^ self subclassResponsibility
]

{ #category : #accessing }
ToFTSelectionModeStrategy >> selectableIndexContainingPoint: aPoint [
	^ self subclassResponsibility
]

{ #category : #adding }
ToFTSelectionModeStrategy >> selectablesToHighlightFromRow: aToFTRow at: aRowIndex withHighlightedIndexes: highligtedIndexes andPrimaryIndex: primarySelectionIndex [
	^ self subclassResponsibility
]

{ #category : #accessing }
ToFTSelectionModeStrategy >> selectedRowIndex [
	^ self rowIndexFrom: self table selectedIndex
]

{ #category : #accessing }
ToFTSelectionModeStrategy >> table [
	^ table
]

{ #category : #accessing }
ToFTSelectionModeStrategy >> table: anObject [
	table := anObject
]

{ #category : #accessing }
ToFTSelectionModeStrategy >> tableContainer [
	^ self table container
]
