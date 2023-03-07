"
Description
--------------------

I am a sorting state for unsorted table.
"
Class {
	#name : #ToFTUnsortedSortingState,
	#superclass : #ToFTAbstractSortingState,
	#category : #'Toplo-FastTable-Sorting'
}

{ #category : #sorting }
ToFTUnsortedSortingState >> executeSortingOn: aDataSource [
	aDataSource unsort
]

{ #category : #accessing }
ToFTUnsortedSortingState >> nextState [
	^ ToFTAscendingSortingState context: self context
]

{ #category : #accessing }
ToFTUnsortedSortingState >> sortingIcon [
	^ self context morphicIconNamed: #arrowUpAndDown
]
