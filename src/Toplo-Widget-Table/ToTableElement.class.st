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
			self performDataSort ]
]

{ #category : #accessing }
ToTableElement >> columns [

	^ columns
]

{ #category : #accessing }
ToTableElement >> columns: anObject [

	columns := anObject
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
	vscrollBar attachTo: self list.
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
			list asScrollableElement }.
	self initScrollBar.
	self property: #columns whenChangedDo: [
			list columns: self columns.
			header columns: self columns ]
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
	"I sort the data based on the information in the column configuration"

	| sortFunctions |
	sortFunctions := self columns
		                 select: [ :column |
			                 column sortOrder isNotNil and: [
				                 column sorterBlock isNotNil ] ]
		                 thenCollect: [ :column |
				                 | sortFunction |
				                 "Build the sort block that also retrieve the computed data from column configuration"
				                 sortFunction := [ :itemA :itemB |
					                                 column sorterBlock
						                                 value:
						                                 (column
							                                  retrieveDataFromDataIndex:
							                                  itemA)
						                                 value:
						                                 (column
							                                  retrieveDataFromDataIndex:
							                                  itemB) ].
				                 "Make the block ascending or descending depending on the configuration"
				                 column sortOrder = #ascending
					                 ifTrue: [ sortFunction ascending ]
					                 ifFalse: [ sortFunction descending ].
				                 sortFunction ].
	sortFunctions do: [ :sortFunction |
		self dataAccessor collection sort: sortFunction ].
	self dataAccessor notifyChanged
]
