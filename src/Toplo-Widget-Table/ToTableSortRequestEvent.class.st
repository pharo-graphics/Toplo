"
I am the event that say a column is asked to be next sorted
"
Class {
	#name : #ToTableSortRequestEvent,
	#superclass : #BlEvent,
	#instVars : [
		'column'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #accessing }
ToTableSortRequestEvent class >> column: aColumn [

	^ self new
		  column: aColumn;
		  yourself
]

{ #category : #accessing }
ToTableSortRequestEvent >> column [

	^ column
]

{ #category : #accessing }
ToTableSortRequestEvent >> column: anObject [

	column := anObject
]

{ #category : #sending }
ToTableSortRequestEvent >> sendTo: anObject [

	anObject columnSortRequestEvent: self
]
