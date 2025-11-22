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

{ #category : #'t - triplet container - instance creation' }
ToTableCellElement >> createEndContainer [

	endContainer := self newLinearContainer
		                  id: #'end-container';
		                  yourself.
	self addChild: endContainer
]

{ #category : #'t - triplet container - instance creation' }
ToTableCellElement >> createStartContainer [

	startContainer := self newLinearContainer
		                  id: #'start-container';
		                  yourself.
	self addChild: startContainer at: 1
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
ToTableCellElement >> newMiddleContainer [

	^ self newLinearContainer
]

{ #category : #accessing }
ToTableCellElement >> updateWidthWith: aNumber [

	self constraintsDo: [ :c | c horizontal exact: aNumber ]
]
