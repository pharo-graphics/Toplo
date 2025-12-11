Class {
	#name : #ToTableColumnContainer,
	#superclass : #ToElement,
	#instVars : [
		'column'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #accessing }
ToTableColumnContainer >> column [

	^ column
]

{ #category : #accessing }
ToTableColumnContainer >> column: aColumn [

	column := aColumn
]
