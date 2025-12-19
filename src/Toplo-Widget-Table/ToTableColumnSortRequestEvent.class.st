Class {
	#name : #ToTableColumnSortRequestEvent,
	#superclass : #BlEvent,
	#instVars : [
		'column'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #accessing }
ToTableColumnSortRequestEvent class >> column: aColumn [

	^ self new
		  column: aColumn;
		  yourself
]

{ #category : #accessing }
ToTableColumnSortRequestEvent >> column [

	^ column
]

{ #category : #accessing }
ToTableColumnSortRequestEvent >> column: anObject [

	column := anObject
]

{ #category : #sending }
ToTableColumnSortRequestEvent >> sendTo: anObject [

	anObject tableColumnSortRequestEvent: self
]
