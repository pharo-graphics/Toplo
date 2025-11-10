Class {
	#name : #ToSortDirection,
	#superclass : #Object,
	#category : #'Toplo-Widget-Table-SortHelper'
}

{ #category : #'as yet unclassified' }
ToSortDirection class >> ascend [

	^ ToSortDirectionAscend new
]

{ #category : #'as yet unclassified' }
ToSortDirection class >> both [

	^ ToSortDirectionBoth new
]

{ #category : #'as yet unclassified' }
ToSortDirection class >> descend [

	^ ToSortDirectionDescend new
]

{ #category : #'as yet unclassified' }
ToSortDirection class >> none [

	^ ToSortDirectionNone new
]

{ #category : #testing }
ToSortDirection >> hasSortAscend [

	^ false
]

{ #category : #testing }
ToSortDirection >> hasSortDescend [

	^ false
]

{ #category : #testing }
ToSortDirection >> isSortAscend [

	^ false
]

{ #category : #testing }
ToSortDirection >> isSortBoth [

	^ false
]

{ #category : #testing }
ToSortDirection >> isSortDescend [

	^ false
]

{ #category : #testing }
ToSortDirection >> isSortNone [

	^ false
]
