"
Description
--------------------

I am a strategy defining a sorting behavior of a FastTable based on a sort function to apply on the row model. 

I'll have three step depending on the current sorting state: 
- Sort ascending
- Sort descending
- Unsort

To manage my state I uses a State design pattern. 	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	sortFunction:		<aSortFunction>		The sortFunction to apply on the elements to sort them.
	state:					<aSortingState> 	The state of the sorting (ascending, descending, unsorted).

"
Class {
	#name : #ToFTSortFunctionColumnSortingStrategy,
	#superclass : #ToFTStateBasedColumnSortingStrategy,
	#instVars : [
		'sortFunction'
	],
	#category : #'Toplo-FastTable-Sorting'
}

{ #category : #'instance creation' }
ToFTSortFunctionColumnSortingStrategy class >> column: aColumn sortFunction: aValuable [
	^ (self column: aColumn)
		sortFunction: aValuable;
		yourself
]

{ #category : #accessing }
ToFTSortFunctionColumnSortingStrategy >> ascendingSortFunction [
	^ self sortFunction
]

{ #category : #accessing }
ToFTSortFunctionColumnSortingStrategy >> sortFunction [
	^ sortFunction
]

{ #category : #accessing }
ToFTSortFunctionColumnSortingStrategy >> sortFunction: aString [
	sortFunction := aString
]
