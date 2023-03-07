"
Description
--------------------

I am a strategy defining a sorting behavior of a FastTable based on the property of the row model. 

I'll have three step depending on the current sorting state: 
- Sort ascending
- Sort descending
- Unsort

To manage my state I uses a State design pattern. 	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	property:		<aValuable>			The property allowing to get the element on which applying the sorting.
	state:			<aSortingState> 	The state of the sorting (ascending, descending, unsorted).

"
Class {
	#name : #ToFTPropertyColumnSortingStrategy,
	#superclass : #ToFTStateBasedColumnSortingStrategy,
	#instVars : [
		'property'
	],
	#category : #'Toplo-FastTable-Sorting'
}

{ #category : #'instance creation' }
ToFTPropertyColumnSortingStrategy class >> column: aColumn property: aValuable [
	^ (self column: aColumn)
		property: aValuable;
		yourself
]

{ #category : #accessing }
ToFTPropertyColumnSortingStrategy >> ascendingSortFunction [
	^ [ :entity | self property value: entity ] ascending
]

{ #category : #accessing }
ToFTPropertyColumnSortingStrategy >> property [
	^ property
]

{ #category : #accessing }
ToFTPropertyColumnSortingStrategy >> property: aString [
	property := aString
]
