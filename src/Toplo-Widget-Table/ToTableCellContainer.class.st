Class {
	#name : #ToTableCellContainer,
	#superclass : #ToTripletContainer,
	#instVars : [
		'column',
		'parentTable'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #accessing }
ToTableCellContainer class >> parentTable: aTableElement [

	^ self basicNew
		  parentTable: aTableElement;
		  initialize;
		  yourself
]

{ #category : #accessing }
ToTableCellContainer >> cell [ 

	^ self middleContainer
]

{ #category : #accessing }
ToTableCellContainer >> column [

	^ column
]

{ #category : #initialization }
ToTableCellContainer >> initializeWithColumn: aTableColumn [

	column ifNotNil: [ (BlImmutableObjectChangeError object: self) signal  ].
	column := aTableColumn.
	self createMiddleContainer.
	self hMatchParent.
	self vFitContent

]

{ #category : #skin }
ToTableCellContainer >> installRawStyle [

	super installRawStyle.

	self padding: (BlInsets
			 horizontal: (self valueOfTokenNamed: #'table-cell-padding-H')
			 vertical: (self valueOfTokenNamed: #'table-cell-padding-V'))
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
ToTableCellContainer >> parentTable: aTableElement [

	parentTable := aTableElement
]

{ #category : #updating }
ToTableCellContainer >> updateWidthWith: aNumber [

	self constraintsDo: [ :c | c horizontal exact: aNumber ]
]
