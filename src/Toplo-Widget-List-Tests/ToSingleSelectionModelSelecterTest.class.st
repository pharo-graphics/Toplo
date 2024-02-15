Class {
	#name : #ToSingleSelectionModelSelecterTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'holder',
		'selectionChanged',
		'selecter'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Selecter'
}

{ #category : #running }
ToSingleSelectionModelSelecterTest >> setUp [

	super setUp.
	selectionChanged := false.
	holder := ToSelectionModelHolderForTest new.
	space root addChild: holder.
	holder data addAll: (1 to: 1000).
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selectionChanged := true ]).
	selecter := holder singleSelectionSelecter
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testDeselectAll [

	selecter selectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: { 2 }.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testDeselectAllIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: { 2 }.
	selecter deselectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: holder selectionModel isEmpty 
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testDeselectIndex [

	selecter selectIndex: 2.
	selecter deselectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testDispatchSelectionChanged [

	| selChangedEvent |
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).

	selecter selectAllIndexes: { 2. 6. 9 }.
	self waitTestingSpaces.
	self assert: selChangedEvent notNil.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: { 2 }.

	selChangedEvent := nil.
	" no change "
	selecter selectAllIndexes: { 2. 6. 9 }.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: { 2 }.
	self waitTestingSpaces.
	self assert: selChangedEvent isNil
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAll [

	selecter selectAll.
	self waitTestingSpaces.
	self deny: holder selectionModel isNotEmpty.
	self
		deny: holder selectionModel isWholeSelectionModel
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAll2 [

	selecter selectAll.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 0.
	self assert: holder selectionModel isEmptySelectionModel
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAllIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes size equals: 1.
	self assert: holder selectionModel selectedIndexes equals: { 2 }
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectAndScrollToIndex: 10.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #(10).
	self assert: selecter currentIndex equals: 10.
	self assert: holder scrollIndex equals: 10

]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToNext [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectAndScrollToNext.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes asSet equals: #(3) asSet.
	self assert: selecter currentIndex equals: 3.
	self assert: holder scrollIndex equals: 3

]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToNextDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectAndScrollToNextDeselected.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 3 ).
	self assert: selecter currentIndex equals: 3.
	selecter selectAndScrollToNextDeselected.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 4 ).
	self assert: selecter currentIndex equals: 4.
	self assert: holder scrollIndex equals: 4

]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToPrevious [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectAndScrollToPrevious.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes asSet equals: #(1) asSet.
	self assert: selecter currentIndex equals: 1.
	self assert: holder scrollIndex equals: 1
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToPreviousDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectAndScrollToPreviousDeselected.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 1 ).
	self assert: selecter currentIndex equals: 1.
	selecter selectAndScrollToPreviousDeselected.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 1 ).
	self assert: selecter currentIndex equals: 1.
	self assert: holder scrollIndex equals: 1
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes size equals: 1.
	self assert: holder selectionModel selectedIndexes first equals: 2
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectIndex2 [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes first equals: 2.
	self assert: selecter currentIndex equals: 2
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectIndexTo [

	selecter selectIndex: 2 to: 10.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes size equals: 1.
	self assert: holder selectionModel selectedIndexes equals: #(10)
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectIndexTo2 [

	selecter selectIndex: 2 to: 10.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 10
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectNextOnLastIndex [

	selecter selectIndex: holder dataSource itemCount.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: holder dataSource itemCount.
	selecter selectAndScrollToNext.
	self waitTestingSpaces.
	self
		assert: holder selectionModel selectedIndexes asSet
		equals: { 1 } asSet.
	self
		assert: selecter currentIndex
		equals: 1.
	self assert: holder scrollIndex equals: 1
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectOnlyIndex [

	selecter deselectAll.
	selecter selectAllIndexes: {2. 6. 9}.
	selecter selectOnlyIndex: 10.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes asSet equals: {10} asSet.
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectOnlyIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter selectOnlyIndexes: {10. 6. 20}.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: { 10 }.
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectPreviousOnFirstIndex [

	selecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 1.
	selecter selectAndScrollToPrevious.
	self waitTestingSpaces.
	self
		assert: holder selectionModel selectedIndexes asSet
		equals: { holder dataSource itemCount } asSet.
	self
		assert: selecter currentIndex
		equals: holder dataSource itemCount.
	self assert: holder scrollIndex equals: holder dataSource itemCount
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectThenDeselectAll [

	selecter selectIndex: 2.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectToIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes first equals: 2.
	self assert: selecter currentIndex equals: 2.
	selecter selectToIndex: 12.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes first equals: 12.
	self assert: holder selectionModel selectedIndexes last equals: 12.
	self assert: selecter currentIndex equals: 12.
	selecter selectToIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes first equals: 2.
	self assert: holder selectionModel selectedIndexes last equals: 2.
	self assert: selecter currentIndex equals: 2

]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectionChanged [

	selecter selectAllIndexes: {2}.
	self waitTestingSpaces.
	self assert: selectionChanged. 

]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll [

	selectionChanged := false.
	selecter selectAllIndexes: {2}.
	self waitTestingSpaces.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: selectionChanged
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll2 [

	selectionChanged := false.
	selecter selectAllIndexes: {2 }.
	self waitTestingSpaces.
	selecter deselectAll.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: selectionChanged
]
