Class {
	#name : #ToSelectionModelSelecterTest,
	#superclass : #TestCase,
	#instVars : [
		'holder',
		'selectionChanged',
		'selecter'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Updater'
}

{ #category : #running }
ToSelectionModelSelecterTest >> setUp [

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
ToSelectionModelSelecterTest >> testAddCommand [

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
ToSelectionModelSelecterTest >> testDeselectAll [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter deselectAll.
	selecter apply.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testDeselectAllIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter deselectAllIndexes: {2. 6. 9}.
	selecter apply.
	self assert: holder selectionModel isEmpty 
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testDeselectIndex [

	selecter selectIndex: 2.
	selecter deselectIndex: 2.
	selecter apply.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testDispatchSelectionChanged [

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
ToSelectionModelSelecterTest >> testSelectAll [

	selecter selectAll.
	selecter apply.
	self assert: holder selectionModel isNotEmpty.
	self
		assert: holder selectionModel isWholeSelectionModel
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectAll2 [

	selecter selectAll.
	selecter apply.
	self assert: selecter currentIndex equals: 0.
	self assert: holder selectionModel isWholeSelectionModel
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectAllIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter apply.
	self assert: holder selectionModel selectedIndexes size equals: 3.
	self assert: holder selectionModel selectedIndexes asSet equals: {2. 6. 9} asSet
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectIndex [

	selecter selectIndex: 2.
	selecter apply.
	self assert: holder selectionModel selectedIndexes size equals: 1.
	self assert: holder selectionModel selectedIndexes first equals: 2
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectIndex2 [

	selecter selectIndex: 2.
	selecter apply.
	self assert: holder selectionModel selectedIndexes first equals: 2.
	self assert: selecter currentIndex equals: 2
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectIndexTo [

	selecter selectIndex: 2 to: 10.
	selecter apply.
	self assert: holder selectionModel selectedIndexes size equals: 9.
	self assert: holder selectionModel selectedIndexes asSet equals: (2 to: 10) asSet
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectIndexTo2 [

	selecter selectIndex: 2 to: 10.
	selecter apply.
	self assert: selecter currentIndex equals: 10
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectNext [

	selecter selectIndex: 2.
	selecter apply.
	self assert: selecter currentIndex equals: 2.
	selecter selectNext.
	selecter apply.
	self assert: holder selectionModel selectedIndexes asSet equals: #(3) asSet.
	self assert: selecter currentIndex equals: 3

]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectNextOnLastIndex [

	selecter selectIndex: holder dataSource itemCount.
	selecter apply.
	self assert: selecter currentIndex equals: holder dataSource itemCount.
	selecter selectNext.
	selecter apply.
	self
		assert: holder selectionModel selectedIndexes asSet
		equals: { 1 } asSet.
	self
		assert: selecter currentIndex
		equals: 1
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectOnlyIndex [

	selecter deselectAll.
	selecter selectAllIndexes: {2. 6. 9}.
	selecter selectOnlyIndex: 10.
	selecter apply.
	self assert: holder selectionModel selectedIndexes asSet equals: {10} asSet.
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectOnlyIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter selectOnlyIndexes: {10. 6. 20}.
	selecter apply.
	self assert: holder selectionModel selectedIndexes asSet equals: {10. 6. 20} asSet.
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectOrDeselectNext [

	selecter deselectAll.
	selecter selectIndex: 2.
	selecter apply.
	selecter selectOrDeselectNext.
	selecter apply.
	self assert: holder selectionModel selectedIndexes equals: #( 2 3 ).
	self assert: selecter currentIndex equals: 3.
	selecter selectOrDeselectNext.
	selecter apply.
	self assert: holder selectionModel selectedIndexes equals: #( 2 3 4 ).
	self assert: selecter currentIndex equals: 4.

]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectOrDeselectPrevious [

	selecter deselectAll.
	selecter selectIndex: 2.
	selecter selectOrDeselectPrevious.
	selecter apply.
	self assert: holder selectionModel selectedIndexes equals: #( 1 2 ).
	self assert: selecter currentIndex equals: 1.
	selecter selectOrDeselectPrevious.
	selecter apply.
	self assert: holder selectionModel selectedIndexes equals: #( 1 2 ).
	self assert: selecter currentIndex equals: 1
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectPrevious [

	selecter selectIndex: 2.
	selecter apply.
	self assert: selecter currentIndex equals: 2.
	selecter selectPrevious.
	selecter apply.
	self assert: holder selectionModel selectedIndexes asSet equals: #(1) asSet.
	self assert: selecter currentIndex equals: 1
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectPreviousOnFirstIndex [

	selecter selectIndex: 1.
	selecter apply.
	self assert: selecter currentIndex equals: 1.
	selecter selectPrevious.
	selecter apply.
	self
		assert: holder selectionModel selectedIndexes asSet
		equals: { holder dataSource itemCount } asSet.
	self
		assert: selecter currentIndex
		equals: holder dataSource itemCount
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectToIndex [

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
ToSelectionModelSelecterTest >> testSelectionChanged [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter apply.
	self assert: selectionChanged. 

]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll [

	selectionChanged := false.
	selecter selectAllIndexes: {2. 6. 9}.
	selecter apply.
	selecter deselectAll.
	selecter apply.
	self assert: selectionChanged
]

{ #category : #tests }
ToSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll2 [

	selectionChanged := false.
	selecter selectAllIndexes: {2. 6. 9}.
	selecter apply.
	selecter deselectAll.
	selecter deselectAll.
	selecter apply.
	self assert: selectionChanged
]
