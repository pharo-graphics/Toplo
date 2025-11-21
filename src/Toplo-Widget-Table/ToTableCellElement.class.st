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
	self layout: BlLinearLayout horizontal.
	self
		hMatchParent;
		vFitContent
]

{ #category : #initialization }
ToTableCellElement >> newColumnState [

	^ ToTableColumnState new
]

{ #category : #accessing }
ToTableCellElement >> onMeasure: anExtentMeasurementSpec [

	| widthSpec |
	super onMeasure: anExtentMeasurementSpec.
	column ifNil: [ ^ self ].
	column width ifNil: [ ^ self ].
	widthSpec := anExtentMeasurementSpec widthSpec.
	widthSpec size: column width.
]

{ #category : #accessing }
ToTableCellElement >> updateWidthWith: aNumber [

	self constraintsDo: [ :c | c horizontal exact: aNumber ]
]
