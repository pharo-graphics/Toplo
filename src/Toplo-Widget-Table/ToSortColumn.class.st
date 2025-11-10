"
I am the event that say a column is asked to be next sorted
"
Class {
	#name : #ToSortColumn,
	#superclass : #BlEvent,
	#instVars : [
		'column'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #accessing }
ToSortColumn class >> column: aColumn [

	^ self new
		  column: aColumn;
		  yourself
]

{ #category : #accessing }
ToSortColumn >> column [

	^ column
]

{ #category : #accessing }
ToSortColumn >> column: anObject [

	column := anObject
]
