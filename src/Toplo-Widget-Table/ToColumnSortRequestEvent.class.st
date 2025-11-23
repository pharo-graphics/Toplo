"
I am the event that say a column is asked to be next sorted
"
Class {
	#name : #ToColumnSortRequestEvent,
	#superclass : #BlEvent,
	#instVars : [
		'column'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #accessing }
ToColumnSortRequestEvent class >> column: aColumn [

	^ self new
		  column: aColumn;
		  yourself
]

{ #category : #accessing }
ToColumnSortRequestEvent >> column [

	^ column
]

{ #category : #accessing }
ToColumnSortRequestEvent >> column: anObject [

	column := anObject
]

{ #category : #sending }
ToColumnSortRequestEvent >> sendTo: anObject [

	anObject columnSortRequestEvent: self
]
