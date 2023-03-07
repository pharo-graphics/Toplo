"
Description
--------------------

I am a sorting state for ascending sorted table.
"
Class {
	#name : #ToFTAscendingSortingState,
	#superclass : #ToFTAbstractSortingState,
	#category : #'Toplo-FastTable-Sorting'
}

{ #category : #sorting }
ToFTAscendingSortingState >> executeSortingOn: aDataSource [
	aDataSource sortWith: self context ascendingSortFunction
]

{ #category : #accessing }
ToFTAscendingSortingState >> nextState [
	^ ToFTDescendingSortingState context: self context
]

{ #category : #accessing }
ToFTAscendingSortingState >> sortingIcon [
	^ self context morphicIconNamed: #arrowUp
]
