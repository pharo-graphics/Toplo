Class {
	#name : #ToMultiSelectionModelSelecterTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'holder',
		'selectionChanged',
		'selecter'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Selecter'
}

{ #category : #running }
ToMultiSelectionModelSelecterTest >> setUp [

	super setUp.
	selectionChanged := false.
	holder := ToSelectionModelHolderForTest new.
	space root addChild: holder.
	holder data addAll: (1 to: 1000).
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selectionChanged := true ]).
	selecter := holder multiSelectionSelecter
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testDeselectAll [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testDeselectAllIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter deselectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: holder selectionModel isEmpty 
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testDeselectIndex [

	selecter selectIndex: 2.
	selecter deselectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testDispatchSelectionChanged [

	| selChangedEvent |
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).

	selecter selectAllIndexes: { 2. 6. 9 }.
	self waitTestingSpaces.
	self assert: selChangedEvent notNil.

	selChangedEvent := nil.
	" no change "
	selecter selectAllIndexes: { 2. 6. 9 }.
	self waitTestingSpaces.
	self assert: selChangedEvent isNil
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAll [

	selecter selectAll.
	self waitTestingSpaces.
	self assert: holder selectionModel isNotEmpty.
	self assert: selecter currentIndex equals: 1.
	self assert: holder selectionModel isWholeSelectionModel
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAllIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes size equals: 3.
	self assert: holder selectionModel selectedIndexes asSet equals: {2. 6. 9} asSet
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAndScrollToIndex [

	selecter selectIndex: 2.
	selecter selectIndex: 10.
	selecter scrollToIndex: 10.
	self waitTestingSpaces.
	self
		assert: holder selectionModel selectedIndexes asSet
		equals: #( 2 10 ) asSet.
	self assert: selecter currentIndex equals: 10.
	self assert: holder scrollIndex equals: 10
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAndScrollToNext [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter nextSelectableIndex.
	selecter scrollToCurrentIndex.
	self waitTestingSpaces.
	self
		assert: holder selectionModel selectedIndexes asSet
		equals: #( 2 3 ) asSet.
	self assert: selecter currentIndex equals: 3.
	self assert: holder scrollIndex equals: 3
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAndScrollToNextDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex:  selecter nextDeselectedIndex.
	selecter scrollToIndex:  selecter currentIndex.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 2 3 ).
	self assert: selecter currentIndex equals: 3.
	selecter selectIndex:  selecter nextDeselectedIndex.
	self waitTestingSpaces.
	selecter scrollToIndex:  selecter currentIndex.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 2 3 4 ).
	self assert: selecter currentIndex equals: 4.
	self assert: holder scrollIndex equals: 4
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAndScrollToPrevious [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter previousSelectableIndex.
	selecter scrollToCurrentIndex.
	self waitTestingSpaces.
	self
		assert: holder selectionModel selectedIndexes asSet
		equals: #( 1 2 ) asSet.
	self assert: selecter currentIndex equals: 1.
	self assert: holder scrollIndex equals: 1
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAndScrollToPreviousDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter previousDeselectedIndex.
	selecter scrollToIndex:  selecter currentIndex.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 1 2 ).
	self assert: selecter currentIndex equals: 1.
	selecter selectIndex: selecter previousDeselectedIndex.
	selecter scrollToIndex:  selecter currentIndex.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 1 2 ).
	self assert: selecter currentIndex equals: 1.
	self assert: holder scrollIndex equals: 1
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes size equals: 1.
	self assert: holder selectionModel selectedIndexes first equals: 2
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectIndex2 [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes first equals: 2.
	self assert: selecter currentIndex equals: 2
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectIndexTo [

	selecter selectIndex: 2 to: 10.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes size equals: 9.
	self assert: holder selectionModel selectedIndexes asSet equals: (2 to: 10) asSet
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectIndexTo2 [

	selecter selectIndex: 2 to: 10.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 10
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectNextOnLastIndex [

	selecter selectIndex: holder dataSource itemCount.
	self waitTestingSpaces.
	self
		assert: selecter currentIndex
		equals: holder dataSource itemCount.
	selecter selectIndex: selecter nextSelectableIndex.
	selecter scrollToCurrentIndex.
	self waitTestingSpaces.
	self
		assert: holder selectionModel selectedIndexes asSet
		equals: { 1000. 1 } asSet.
	self assert: selecter currentIndex equals: 1.
	self assert: holder scrollIndex equals: 1
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectOnlyIndex [

	selecter deselectAll.
	selecter selectAllIndexes: {2. 6. 9}.
	selecter selectOnlyIndex: 10.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes asSet equals: {10} asSet.
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectOnlyIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter selectOnlyIndexes: {10. 6. 20}.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes asSet equals: {10. 6. 20} asSet.
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectPreviousOnFirstIndex [

	selecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 1.
	selecter selectIndex: selecter previousSelectableIndex.
	selecter scrollToCurrentIndex.
	self waitTestingSpaces.
	self
		assert: holder selectionModel selectedIndexes 
		equals: { 1. holder dataSource itemCount } .
	self
		assert: selecter currentIndex
		equals: holder dataSource itemCount.
	self assert: holder scrollIndex equals: holder dataSource itemCount
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectThenDeselectAll [

	selecter selectIndex: 2.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectToIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes first equals: 2.
	self assert: selecter currentIndex equals: 2.
	selecter selectToIndex: 12.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes first equals: 2.
	self assert: holder selectionModel selectedIndexes last equals: 12.
	self assert: selecter currentIndex equals: 12.
	selecter selectToIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes first equals: 2.
	self assert: holder selectionModel selectedIndexes last equals: 12.
	self assert: selecter currentIndex equals: 2

]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectionChanged [

	selecter selectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: selectionChanged. 

]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll [

	selectionChanged := false.
	selecter selectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: selectionChanged
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll2 [

	selectionChanged := false.
	selecter selectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	selecter deselectAll.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: selectionChanged
]
