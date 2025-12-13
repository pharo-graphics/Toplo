Class {
	#name : #ToTableHeaderCellContainer,
	#superclass : #ToTableCellContainer,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #'instance creation' }
ToTableHeaderCellContainer class >> column: aColumn [

	^ self new
		  initializeWithColumn: aColumn;
		  yourself
]

{ #category : #updating }
ToTableHeaderCellContainer >> initializeFromColumnInTableElement: aTableElement [

	column buildHeaderCellInContainer: self inTableElement: aTableElement.
	column sorterBlock ifNotNil: [
			| sorterContainer |
			sorterContainer := self newSorterContainer.
			self ensureEndContainer.
			self endContainer addChild: sorterContainer.
			column sorterContainerBuilder
				cull: sorterContainer
				cull: column
				cull: aTableElement ]
]

{ #category : #skin }
ToTableHeaderCellContainer >> installRawStyle [ 

	super installRawStyle.
	self padding: (BlInsets
				 horizontal: (self valueOfTokenNamed: #'list-node-padding-H') 
				 vertical: (self valueOfTokenNamed: #'list-node-padding-V'))
]

{ #category : #'t - triplet container - instance creation' }
ToTableHeaderCellContainer >> newMiddleContainer [ 

	^ column headerCellFactory value
]

{ #category : #updating }
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
