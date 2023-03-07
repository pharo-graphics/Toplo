"
Description
--------------------

I am a sorting state for descending sorted table.
"
Class {
	#name : #ToFTDescendingSortingState,
	#superclass : #ToFTAbstractSortingState,
	#category : #'Toplo-FastTable-Sorting'
}

{ #category : #sorting }
ToFTDescendingSortingState >> executeSortingOn: aDataSource [
	aDataSource sortWith: self context ascendingSortFunction reversed
]

{ #category : #accessing }
ToFTDescendingSortingState >> nextState [
	^ ToFTUnsortedSortingState context: self context
]

{ #category : #accessing }
ToFTDescendingSortingState >> sortingIcon [
	^ self context morphicIconNamed: #arrowDown
]
