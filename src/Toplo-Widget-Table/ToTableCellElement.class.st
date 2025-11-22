Class {
	#name : #ToTableCellElement,
	#superclass : #ToTripletContainer,
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
	self createStartContainer.
	self createEndContainer
]

{ #category : #initialization }
ToTableCellElement >> newColumnState [

	^ ToTableColumnState new
]

{ #category : #'t - triplet container - instance creation' }
ToTableCellElement >> newEndContainer [

	^ self newLinearContainer
]

{ #category : #'t - triplet container - instance creation' }
ToTableCellElement >> newMiddleContainer [

	^ self newLinearContainer
]

{ #category : #'t - triplet container - instance creation' }
ToTableCellElement >> newStartContainer [

	^ self newLinearContainer
]

{ #category : #accessing }
ToTableCellElement >> updateWidthWith: aNumber [

	self constraintsDo: [ :c | c horizontal exact: aNumber ]
]
