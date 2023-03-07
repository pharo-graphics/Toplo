"
Description
--------------------

I am an abstract class defining the state management of ToFTAbstractColumnSortingStrategy subclasses using a state to sort the table.

My subclasses should only define a sort function to be used by the state to sort the FastTable.
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	state:			<aSortingState> 	The state of the sorting (ascending, descending, unsorted).

"
Class {
	#name : #ToFTStateBasedColumnSortingStrategy,
	#superclass : #ToFTAbstractColumnSortingStrategy,
	#instVars : [
		'state'
	],
	#category : #'Toplo-FastTable-Sorting'
}

{ #category : #accessing }
ToFTStateBasedColumnSortingStrategy >> ascendingSortFunction [
	^ self subclassResponsibility
]

{ #category : #initialization }
ToFTStateBasedColumnSortingStrategy >> initialize [
	super initialize.
	self reset
]

{ #category : #initialization }
ToFTStateBasedColumnSortingStrategy >> reset [
	self state: (ToFTUnsortedSortingState context: self)
]

{ #category : #sorting }
ToFTStateBasedColumnSortingStrategy >> sortDataSource: aDataSource [
	self state sort: aDataSource
]

{ #category : #accessing }
ToFTStateBasedColumnSortingStrategy >> sortingIcon [
	^ self state sortingIcon
]

{ #category : #accessing }
ToFTStateBasedColumnSortingStrategy >> state [
	^ state
]

{ #category : #accessing }
ToFTStateBasedColumnSortingStrategy >> state: anObject [
	state := anObject
]
