Class {
	#name : #ToTableCellContainer,
	#superclass : #ToTripletContainer,
	#instVars : [
		'column'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #'instance creation' }
ToTableCellContainer class >> new [

	^ Error signal: 'Use the adequate subclass constructor instead'
]

{ #category : #accessing }
ToTableCellContainer >> cell [ 

	^ self middleContainer
]

{ #category : #accessing }
ToTableCellContainer >> column [

	^ column
]

{ #category : #accessing }
ToTableCellContainer >> column: aTableColumn [

	column := aTableColumn
]

{ #category : #initialization }
ToTableCellContainer >> initialize [

	super initialize.
	self createStartContainer.
	self createEndContainer
]

{ #category : #initialization }
ToTableCellContainer >> newColumnState [

	^ ToTableColumnState new
]

{ #category : #'t - triplet container - instance creation' }
ToTableCellContainer >> newEndContainer [

	^ self newLinearContainer
]

{ #category : #'t - triplet container - instance creation' }
ToTableCellContainer >> newMiddleContainer [

	^ self newLinearContainer
]

{ #category : #'t - triplet container - instance creation' }
ToTableCellContainer >> newStartContainer [

	^ self newLinearContainer
]

{ #category : #accessing }
ToTableCellContainer >> updateWidthWith: aNumber [

	self constraintsDo: [ :c | c horizontal exact: aNumber ]
]
