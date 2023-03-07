"
Description
--------------------

I am class managing the behavior of the sorting of a FastTable when the sorting is disabled.

By default I will display nothing in the header cell and do nothing we I am asked to sort the datasource of the table.
"
Class {
	#name : #ToFTNullColumnSortingStrategy,
	#superclass : #ToFTAbstractColumnSortingStrategy,
	#category : #'Toplo-FastTable-Sorting'
}

{ #category : #testing }
ToFTNullColumnSortingStrategy >> isSortingEnabled [
	^ false
]

{ #category : #initialization }
ToFTNullColumnSortingStrategy >> reset [
	"Nothing for this one"
]

{ #category : #sorting }
ToFTNullColumnSortingStrategy >> sortDataSource: aDataSource [
	"Nothing to do here"
]

{ #category : #accessing }
ToFTNullColumnSortingStrategy >> sortingIcon [
	^ nil
]
