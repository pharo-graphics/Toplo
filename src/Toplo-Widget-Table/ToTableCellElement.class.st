Class {
	#name : #ToTableCellElement,
	#superclass : #ToElement,
	#instVars : [
		'column'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #accessing }
ToTableCellElement >> column [

	^ column
]

{ #category : #accessing }
ToTableCellElement >> column: aTableColumn [

	column := aTableColumn
]

{ #category : #initialization }
ToTableCellElement >> initialize [

	super initialize.
	self
		hMatchParent;
		vFitContent
]

{ #category : #accessing }
ToTableCellElement >> updateWidthWith: aNumber [

	self constraintsDo: [ :c | c horizontal exact: aNumber ]
]
