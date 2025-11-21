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
		'#showHeader => ObservableSlot',
		'#header',
		'#list'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #initialization }
ToTableElement >> buildHeader [

	header := self newHeaderElement
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
	vscrollBar elevation: (BlRelativeElevation elevation: 20).
	self list addChild: vscrollBar
]

{ #category : #initialization }
ToTableElement >> initialize [

	super initialize.
	self class initializeSlots: self.

	self matchParent.
	self padding: (BlInsets all: 1).
	list := self newListElement 
		  id: #list;
		  yourself.
	self buildHeader.
	self addChildren: {
			header.
			list }.
	self initScrollBar.
	self property: #columns whenChangedDo: [
			list columns: self columns.
			header columns: self columns inTableElement: self.
			self initializeDividers ].
	self property: #showHeader whenChangedDo: [
			showHeader
				ifTrue: [ header constraintsDo: [ :c | c vertical fitContent ] ]
				ifFalse: [ header constraintsDo: [ :c | c vertical exact: 0.0 ] ] ].
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

{ #category : #'event handling' }
ToTableElement >> newHeaderCheckboxInColumn: aColumn [

	| cbox |
	cbox := ToCheckbox new.
	cbox allowIndeterminate: true.
	cbox focusability: BlFocusability none.
	cbox switchToNextCheckStateOnClick: false.
	self updateHeaderCheckboxForListSelection: cbox.

	" In case the checkbox has been clicked, update the list selection "
	cbox
		addEventHandlerOn: BlClickEvent
		do: [ :event | self updateListSelectionFromHeaderCheckbox: cbox ].

	list
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ :event | self updateHeaderCheckboxForListSelection: cbox ].

	^ cbox
]

{ #category : #initialization }
ToTableElement >> newHeaderElement [

	^ ToTableHeaderElement new
]

{ #category : #initialization }
ToTableElement >> newListElement [

	^ ToTableListElement new
]

{ #category : #accessing }
ToTableElement >> nodeManager [

	^ list nodeManager
]

{ #category : #sorting }
ToTableElement >> performDataSort [

	| sortFunctions |
	"I sort the data based on the information in the column configuration.
	for now sort by column from left to right. Future should implement an order of sorting"
	sortFunctions := (self columns
		                  select: [ :col |
		                  col sortOrder isNotNil and: [
			                  col sorterBlock isNotNil ] ]
		                  thenCollect: [ :col |
				                  | f |
				                  "reverse sort function in case of descending"
				                  f := col sorterBlock asSortFunction.
				                  col sortOrder = #descending ifFalse: [
					                  f := f reversed ].
				                  col -> f ]) asDictionary.
	self updateSelectionAfter: [
			sortFunctions keysAndValuesDo: [ :keyColumn :valueSortFunction |
					self dataAccessor sort: [ :item1 :item2 |
						valueSortFunction value: item1 value: item2 ] ] ]
]

{ #category : #accessing }
ToTableElement >> selecter [

	^ self list selecter
]

{ #category : #accessing }
ToTableElement >> showHeader: aBoolean [

	showHeader := aBoolean
]

{ #category : #initialization }
ToTableElement >> updateDividers [

	| dividers |
	dividers := self selectChildrenWithId: #columnDivider.
	self whenLayoutedDoOnce: [
		dividers do: [ :div | div setPositionInTable: self ] ]
]

{ #category : #'event handling' }
ToTableElement >> updateHeaderCheckboxForListSelection: aCheckbox [

	| selectedIndexes |
	selectedIndexes := list selecter selectedIndexes.
	(selectedIndexes notEmpty and: [
		 selectedIndexes size = list dataAccessor itemCount ])
		ifTrue: [ aCheckbox checked: true ]
		ifFalse: [
				selectedIndexes isEmpty
					ifTrue: [ aCheckbox checked: false ]
					ifFalse: [ aCheckbox checked: #indeterminate ] ]
]

{ #category : #'event handling' }
ToTableElement >> updateListSelectionFromHeaderCheckbox: aCheckbox [

	(aCheckbox isIndeterminate or: [ aCheckbox isChecked not ])
		ifTrue: [ list selecter selectAll ]
		ifFalse: [ list selecter deselectAll ]
]

{ #category : #'selection updating' }
ToTableElement >> updateSelectionAfter: aValuable [

	list updateSelectionAfter: aValuable
]
