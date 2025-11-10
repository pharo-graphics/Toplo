"
Represent that a list can be sorted in both ascending and descending way
"
Class {
	#name : #ToSortDirectionBoth,
	#superclass : #ToSortDirection,
	#category : #'Toplo-Widget-Table-SortHelper'
}

{ #category : #testing }
ToSortDirectionBoth >> hasSortAscend [

	^ true
]

{ #category : #testing }
ToSortDirectionBoth >> hasSortDescend [ 

	^ true
]

{ #category : #testing }
ToSortDirectionBoth >> isSortBoth [

	^ true
]
