Class {
	#name : #ToListElementSelecterTest,
	#superclass : #TestCase,
	#instVars : [
		'holder',
		'selectionChanged',
		'selecter'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Selecter'
}

{ #category : #running }
ToListElementSelecterTest >> setUp [

	super setUp.
	selectionChanged := false.
	holder := ToSelectionModelHolderForTest new.
	holder data addAll: (1 to: 1000).
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selectionChanged := true ]).
	selecter := holder selecter
]

{ #category : #tests }
ToListElementSelecterTest >> testAddCommand [

	| selChangedEvent selRequestEvent cmd |
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).
	holder addEventHandler: (BlEventHandler
			 on: ToSelectionRequestEvent
			 do: [ :event | selRequestEvent := event ]).

	selecter addCommand: (cmd := ToWholeSelectionCommand new
			        operation: ToAddSelectionOperation new;
			        yourself).
	selecter apply.
	self assert: holder selectionModel isNotEmpty.
	self assert: selChangedEvent notNil.
	self assert: selRequestEvent notNil.
	self assert: selRequestEvent command identicalTo: cmd
]

{ #category : #tests }
ToListElementSelecterTest >> testDeselectAll [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter deselectAll.
	selecter apply.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToListElementSelecterTest >> testDeselectAllIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter deselectAllIndexes: {2. 6. 9}.
	selecter apply.
	self assert: holder selectionModel isEmpty 
]

{ #category : #tests }
ToListElementSelecterTest >> testDeselectIndex [

	selecter selectIndex: 2.
	selecter deselectIndex: 2.
	selecter apply.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToListElementSelecterTest >> testDispatchSelectionChanged [

	| selChangedEvent |
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).

	selecter selectAllIndexes: { 2. 6. 9 }.
	selecter apply.
	self assert: selChangedEvent notNil.

	selChangedEvent := nil.
	" no change "
	selecter selectAllIndexes: { 2. 6. 9 }.
	selecter apply.
	self assert: selChangedEvent isNil
]

{ #category : #tests }
ToListElementSelecterTest >> testSelectAll [

	selecter selectAll.
	selecter apply.
	self assert: holder selectionModel isNotEmpty.
	self
		assert: holder selectionModel isWholeSelectionModel
]

{ #category : #tests }
ToListElementSelecterTest >> testSelectAll2 [

	selecter selectAll.
	selecter apply.
	self assert: selecter currentIndex equals: 0.
	self assert: holder selectionModel isWholeSelectionModel
]

{ #category : #tests }
ToListElementSelecterTest >> testSelectAllIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter apply.
	self assert: holder selectionModel selectedIndexes size equals: 3.
	self assert: holder selectionModel selectedIndexes asSet equals: {2. 6. 9} asSet
]

{ #category : #tests }
ToListElementSelecterTest >> testSelectAndScrollToIndex [

	selecter selectIndex: 2.
	selecter selectAndScrollToIndex: 10.
	selecter apply.
	self assert: holder selectionModel selectedIndexes asSet equals: #(2 10) asSet.
	self assert: selecter currentIndex equals: 10.
	self assert: holder scrollIndex equals: 10

]

{ #category : #tests }
ToListElementSelecterTest >> testSelectAndScrollToNext [

	selecter selectIndex: 2.
	selecter selectAndScrollToNext.
	selecter apply.
	self assert: holder selectionModel selectedIndexes asSet equals: #(3) asSet.
	self assert: selecter currentIndex equals: 3.
	self assert: holder scrollIndex equals: 3

]

{ #category : #tests }
ToListElementSelecterTest >> testSelectAndScrollToNextDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	selecter selectAndScrollToNextDeselected.
	selecter apply.
	self assert: holder selectionModel selectedIndexes equals: #( 2 3 ).
	self assert: selecter currentIndex equals: 3.
	selecter selectAndScrollToNextDeselected.
	selecter apply.
	self assert: holder selectionModel selectedIndexes equals: #( 2 3 4 ).
	self assert: selecter currentIndex equals: 4.
	self assert: holder scrollIndex equals: 4

]

{ #category : #tests }
ToListElementSelecterTest >> testSelectAndScrollToPrevious [

	selecter selectIndex: 2.
	selecter selectAndScrollToPrevious.
	selecter apply.
	self assert: holder selectionModel selectedIndexes asSet equals: #(1) asSet.
	self assert: selecter currentIndex equals: 1.
	self assert: holder scrollIndex equals: 1
]

{ #category : #tests }
ToListElementSelecterTest >> testSelectAndScrollToPreviousDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	selecter selectAndScrollToPreviousDeselected.
	selecter apply.
	self assert: holder selectionModel selectedIndexes equals: #( 1 2 ).
	self assert: selecter currentIndex equals: 1.
	selecter selectAndScrollToPreviousDeselected.
	selecter apply.
	self assert: holder selectionModel selectedIndexes equals: #( 1 2 ).
	self assert: selecter currentIndex equals: 1.
	self assert: holder scrollIndex equals: 1
]

{ #category : #tests }
ToListElementSelecterTest >> testSelectIndex [

	selecter selectIndex: 2.
	selecter apply.
	self assert: holder selectionModel selectedIndexes size equals: 1.
	self assert: holder selectionModel selectedIndexes first equals: 2
]

{ #category : #tests }
ToListElementSelecterTest >> testSelectIndex2 [

	selecter selectIndex: 2.
	selecter apply.
	self assert: holder selectionModel selectedIndexes first equals: 2.
	self assert: selecter currentIndex equals: 2
]

{ #category : #tests }
ToListElementSelecterTest >> testSelectIndexTo [

	selecter selectIndex: 2 to: 10.
	selecter apply.
	self assert: holder selectionModel selectedIndexes size equals: 9.
	self assert: holder selectionModel selectedIndexes asSet equals: (2 to: 10) asSet
]

{ #category : #tests }
ToListElementSelecterTest >> testSelectIndexTo2 [

	selecter selectIndex: 2 to: 10.
	selecter apply.
	self assert: selecter currentIndex equals: 10
]

{ #category : #tests }
ToListElementSelecterTest >> testSelectNextOnLastIndex [

	selecter selectIndex: holder dataSource itemCount.
	selecter apply.
	self assert: selecter currentIndex equals: holder dataSource itemCount.
	selecter selectAndScrollToNext.
	selecter apply.
	self
		assert: holder selectionModel selectedIndexes asSet
		equals: { 1 } asSet.
	self
		assert: selecter currentIndex
		equals: 1.
	self assert: holder scrollIndex equals: 1
]

{ #category : #tests }
ToListElementSelecterTest >> testSelectOnlyIndex [

	selecter deselectAll.
	selecter selectAllIndexes: {2. 6. 9}.
	selecter selectOnlyIndex: 10.
	selecter apply.
	self assert: holder selectionModel selectedIndexes asSet equals: {10} asSet.
]

{ #category : #tests }
ToListElementSelecterTest >> testSelectOnlyIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter selectOnlyIndexes: {10. 6. 20}.
	selecter apply.
	self assert: holder selectionModel selectedIndexes asSet equals: {10. 6. 20} asSet.
]

{ #category : #tests }
ToListElementSelecterTest >> testSelectPreviousOnFirstIndex [

	selecter selectIndex: 1.
	self assert: selecter currentIndex equals: 1.
	selecter selectAndScrollToPrevious.
	selecter apply.
	self
		assert: holder selectionModel selectedIndexes asSet
		equals: { holder dataSource itemCount } asSet.
	self
		assert: selecter currentIndex
		equals: holder dataSource itemCount.
	self assert: holder scrollIndex equals: holder dataSource itemCount
]

{ #category : #tests }
ToListElementSelecterTest >> testSelectThenDeselectAll [

	selecter selectIndex: 2.
	selecter deselectAll.
	selecter apply.
	self assert: holder selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToListElementSelecterTest >> testSelectToIndex [

	selecter selectIndex: 2.
	selecter apply.
	self assert: holder selectionModel selectedIndexes first equals: 2.
	self assert: selecter currentIndex equals: 2.
	selecter selectToIndex: 12.
	selecter apply.
	self assert: holder selectionModel selectedIndexes first equals: 2.
	self assert: holder selectionModel selectedIndexes last equals: 12.
	self assert: selecter currentIndex equals: 12.
	selecter selectToIndex: 2.
	selecter apply.
	self assert: holder selectionModel selectedIndexes first equals: 2.
	self assert: holder selectionModel selectedIndexes last equals: 12.
	self assert: selecter currentIndex equals: 2

]

{ #category : #tests }
ToListElementSelecterTest >> testSelectionChanged [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter apply.
	self assert: selectionChanged. 

]

{ #category : #tests }
ToListElementSelecterTest >> testSelectionChangedOnDeselectAll [

	selectionChanged := false.
	selecter selectAllIndexes: {2. 6. 9}.
	selecter apply.
	selecter deselectAll.
	selecter apply.
	self assert: selectionChanged
]

{ #category : #tests }
ToListElementSelecterTest >> testSelectionChangedOnDeselectAll2 [

	selectionChanged := false.
	selecter selectAllIndexes: {2. 6. 9}.
	selecter apply.
	selecter deselectAll.
	selecter deselectAll.
	selecter apply.
	self assert: selectionChanged
]
