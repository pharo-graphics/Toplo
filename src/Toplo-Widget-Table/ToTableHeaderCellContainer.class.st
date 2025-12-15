Class {
	#name : #ToTableHeaderCellContainer,
	#superclass : #ToTableCellContainer,
	#instVars : [
		'state'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #'instance creation' }
ToTableHeaderCellContainer class >> column: aColumn [

	^ self new
		  initializeWithColumn: aColumn;
		  yourself
]

{ #category : #initialization }
ToTableHeaderCellContainer >> initializeWithColumn: aColumn [

	super initializeWithColumn: aColumn.
	state := ToTableColumnState new.
	state initializeWithColumn: aColumn.
	column width
		ifNotNil: [ :w | self width: w ]
		ifNil: [ self hMatchParent ].
	column buildHeaderCellInContainer: self inTableElement: parentTable.
	column sorterBlock ifNotNil: [
			| sorterContainer |
			sorterContainer := self newSorterContainer.
			self ensureEndContainer.
			self endContainer addChild: sorterContainer.
			column sorterContainerBuilder
				cull: sorterContainer
				cull: column
				cull: parentTable ]
]

{ #category : #skin }
ToTableHeaderCellContainer >> installRawStyle [

	super installRawStyle.
	self
		addTokenNamed: #'font-weight-attribute'
		withValue: BlFontWeightAttribute bold
]

{ #category : #'t - triplet container - instance creation' }
ToTableHeaderCellContainer >> newMiddleContainer [ 

	^ column headerCellFactory value
]

{ #category : #initialization }
ToTableHeaderCellContainer >> newSorterContainer [

	| sorterContainer |
	sorterContainer := ToElement new
		                   id: #sorterContainer;
		                   yourself.
	sorterContainer layout: BlLinearLayout horizontal.
	sorterContainer fitContent.
	sorterContainer constraintsDo: [ :c | c linear vertical alignCenter ].
	^ sorterContainer
]

{ #category : #accessing }
ToTableHeaderCellContainer >> state [

	^ state
]

{ #category : #updating }
ToTableHeaderCellContainer >> updateWidthWith: aNumber [

	super updateWidthWith: aNumber.
	state width: aNumber
]
