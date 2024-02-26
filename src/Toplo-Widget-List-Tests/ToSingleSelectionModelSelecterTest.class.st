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
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | selectionChanged := true ]).
	selecter := holder singleSelectionSelecter
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testDeselectAll [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: { 2 }.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testDeselectIndex [

	selecter selectIndex: 2.
	selecter deselectIndex: 2
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testDeselectIndexes [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 2 ).
	selecter deselectIndexes: {3. 6. 9}.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 2 ).
	selecter deselectIndexes: {3. 2. 9}.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #(  ).



	
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testDispatchSelectionChanged [

	| selChangedEvent |
	holder addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: selChangedEvent notNil.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: { 2 }.

	selChangedEvent := nil.
	" no change "
	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: { 2 }.
	self waitTestingSpaces.
	self assert: selChangedEvent isNil
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAll [

	self should: [selecter selectAll] raise: Error.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 0.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: 10.
	self waitTestingSpaces.
	selecter scrollToIndex:  selecter currentIndex.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 10 ).
	self assert: selecter currentIndex equals: 10.
	self assert: holder scrollIndex equals: 10
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToNext [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter nextSelectableIndex.
	selecter scrollToIndex: selecter currentIndex.
	self waitTestingSpaces.
	self
		assert: holder selectionModel selectedIndexes asSet
		equals: #( 3 ) asSet.
	self assert: selecter currentIndex equals: 3.
	self assert: holder scrollIndex equals: 3
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToNextDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter nextDeselectedIndex.
	self waitTestingSpaces.
	selecter scrollToIndex: selecter currentIndex.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 3 ).
	self assert: selecter currentIndex equals: 3.
	selecter selectIndex: selecter nextDeselectedIndex.
	self waitTestingSpaces.
	selecter scrollToIndex: selecter currentIndex.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 4 ).
	self assert: selecter currentIndex equals: 4.
	self assert: holder scrollIndex equals: 4
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToPrevious [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter previousSelectableIndex.
	selecter scrollToIndex: selecter currentIndex.
	self waitTestingSpaces.
	self
		assert: holder selectionModel selectedIndexes asSet
		equals: #( 1 ) asSet.
	self assert: selecter currentIndex equals: 1.
	self assert: holder scrollIndex equals: 1
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToPreviousDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter previousDeselectedIndex.
	selecter scrollToIndex:  selecter currentIndex.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 1 ).
	self assert: selecter currentIndex equals: 1.
	selecter selectIndex: selecter previousDeselectedIndex.
	selecter scrollToIndex:  selecter currentIndex.
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

	self should: [selecter selectIndex: 2 to: 4] raise: Error.
	self should: [selecter selectIndex: 4 to: 2] raise: Error.
	selecter selectIndex: 2 to: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes  equals: {2} .
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectIndexes [

	self should: [selecter selectIndexes: {2. 6. 9} ] raise: Error

]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectNextOnLastIndex [

	selecter selectIndex: holder dataSource itemCount.
	self waitTestingSpaces.
	self
		assert: selecter currentIndex
		equals: holder dataSource itemCount.
	selecter selectIndex: selecter nextSelectableIndex.
	selecter scrollToIndex: selecter currentIndex.
	self waitTestingSpaces.
	self
		assert: holder selectionModel selectedIndexes asSet
		equals: { 1 } asSet.
	self assert: selecter currentIndex equals: 1.
	self assert: holder scrollIndex equals: 1
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectOnlyIndex [

	selecter deselectAll.
	selecter selectIndex: 2.
	selecter selectOnlyIndex: 10.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes asSet equals: {10} asSet.
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectOnlyIndexes [

	self should: [selecter selectIndexes: {2. 6. 9} ] raise: Error
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectPreviousOnFirstIndex [

	selecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 1.
	selecter selectIndex: selecter previousSelectableIndex.
	selecter scrollToIndex: selecter currentIndex.
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
	self should: [selecter selectIndex: 2 to: 12 ] raise: Error
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectionChanged [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: selectionChanged. 

]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll [

	selectionChanged := false.
	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: selectionChanged.
	selectionChanged := false.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: selectionChanged.
	selectionChanged := false.
	selecter deselectAll.
	self waitTestingSpaces.
	self deny: selectionChanged
]
