"
I am the main entry point to reprensent a Table based on the [ant design](https://ant.design/components/table)
"
Class {
	#name : #ToTableElement,
	#superclass : #ToElement,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#columns => ObservableSlot',
		'#showHeader',
		'#header',
		'#list'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #initialization }
ToTableElement >> buildHeader [

	header := ToTableHeaderElement new
		          id: #header;
		          yourself.
	self addEventHandlerOn: ToSortColumn do: [ :event |
			event consume.
			self performDataSort ]
]

{ #category : #accessing }
ToTableElement >> columns [

	^ columns
]

{ #category : #accessing }
ToTableElement >> columns: aTableColumnArray [

	columns := aTableColumnArray
]

{ #category : #accessing }
ToTableElement >> dataAccessor [

	^ self list dataAccessor
]

{ #category : #initialization }
ToTableElement >> defaultLayout [ 

	" don't use vertical or horizontal to allow vertical centering of children "
	^ BlLinearLayout vertical
]

{ #category : #initialization }
ToTableElement >> freezeCellsWidth [

	header freezeCellsWidth.
	list freezeCellsWidth
]

{ #category : #accessing }
ToTableElement >> header [

	^ header
]

{ #category : #accessing }
ToTableElement >> header: anObject [

	header := anObject
]

{ #category : #initialization }
ToTableElement >> initScrollBar [

	| vscrollBar |
	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets left: 10).
			c ignored horizontal alignRight.
			c ignored vertical alignBottom ].
	vscrollBar attachTo: self list innerElement.
	self list addChild: vscrollBar
]

{ #category : #initialization }
ToTableElement >> initialize [

	super initialize.
	self class initializeSlots: self.
	self matchParent.
	list := ToTableListElement new
		        id: #list;
		        yourself.
	self buildHeader.
	self addChildren: {
			header.
			list }.
	self initScrollBar.
	self property: #columns whenChangedDo: [
			list columns: self columns.
			header columns: self columns.
			self initializeDividers ].
	self addEventHandler: ToTableElementEventHandler new
]

{ #category : #initialization }
ToTableElement >> initializeDividers [

	| headerColumnElements index |
	headerColumnElements := self header cells.
	index := 0.
	self whenLayoutedDoOnce: [
			headerColumnElements overlappingPairsDo: [ :first :second |
					| div col |
					index := index + 1.
					col := columns at: index.
					col resizable ifTrue: [
							div := ToTableDivider new
								       id: #columnDivider;
								       yourself.
							div cellIndex: index.
							div setPositionInTable: self.
							self addChild: div.
							div
								addEventHandlerOn: ToDividerStartDragEvent
								do: [ :event | self dispatchEvent: event ].
							div
								addEventHandlerOn: ToDividerDragEvent
								do: [ :event | self dispatchEvent: event ] ] ] ]
]

{ #category : #accessing }
ToTableElement >> list [

	^ list
]

{ #category : #accessing }
ToTableElement >> list: anObject [

	list := anObject
]

{ #category : #sorting }
ToTableElement >> performDataSort [

	| sortFunctions |
	"I sort the data based on the information in the column configuration""for now sort by column from left to right. Future should implement an order of sorting"
	sortFunctions := (self columns
		                  select: [ :column |
			                  column sortOrder isNotNil and: [
				                  column sorterBlock isNotNil ] ]
		                  thenCollect: [ :column |
				                  | sortFunction |
				                  "reverse sort function in case of descending"
				                  sortFunction := column sortOrder = #descending
					                                  ifFalse: [
					                                  column sorterBlock
						                                  asSortFunction reversed ]
					                                  ifTrue: [
					                                  column sorterBlock
						                                  asSortFunction ].
				                  column -> sortFunction ]) asDictionary.
	sortFunctions keysAndValuesDo: [ :keyColumn :valueSortFunction |
			self dataAccessor collection sort: [ :item1 :item2 |
				valueSortFunction value: item1 value: item2 ] ].
	self dataAccessor notifyChanged
]

{ #category : #initialization }
ToTableElement >> updateDividers [

	| dividers |
	dividers := self selectChildrenWithId: #columnDivider.
	self whenLayoutedDoOnce: [
		dividers do: [ :div | div setPositionInTable: self ] ]
]
