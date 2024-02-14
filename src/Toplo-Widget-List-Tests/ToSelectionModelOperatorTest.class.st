Class {
	#name : #ToSelectionModelOperatorTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'holder',
		'selectionChanged',
		'selecter'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Selecter'
}

{ #category : #running }
ToSelectionModelOperatorTest >> setUp [

	super setUp.
	selectionChanged := false.
	holder := ToSelectionModelHolderForTest new.
	space root addChild: holder.
	holder data addAll: (1 to: 1000).
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selectionChanged := true ]).
	selecter := holder selecter
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testAddCommand [

	| selChangedEvent cmd |
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).

	selecter addCommand: (cmd := ToWholeSelectionCommand new
			        operation: ToAddSelectionOperation new;
			        yourself).
	self waitTestingSpaces.
	self assert: holder selectionModel isNotEmpty.
	self assert: selChangedEvent notNil
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testDeselectAll [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testDeselectAllIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter deselectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: holder selectionModel isEmpty 
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testDeselectIndex [

	selecter selectIndex: 2.
	selecter deselectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testDispatchSelectionChanged [

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
ToSelectionModelOperatorTest >> testSelectAll [

	selecter selectAll.
	self waitTestingSpaces.
	self assert: holder selectionModel isNotEmpty.
	self
		assert: holder selectionModel isWholeSelectionModel
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectAll2 [

	selecter selectAll.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 0.
	self assert: holder selectionModel isWholeSelectionModel
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectAllIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes size equals: 3.
	self assert: holder selectionModel selectedIndexes asSet equals: {2. 6. 9} asSet
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectAndScrollToIndex [

	selecter selectIndex: 2.
	selecter selectAndScrollToIndex: 10.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes asSet equals: #(2 10) asSet.
	self assert: selecter currentIndex equals: 10.
	self assert: holder scrollIndex equals: 10

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectAndScrollToNext [

	selecter selectIndex: 2.
	selecter selectAndScrollToNext.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes asSet equals: #(3) asSet.
	self assert: selecter currentIndex equals: 3.
	self assert: holder scrollIndex equals: 3

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectAndScrollToNextDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	selecter selectAndScrollToNextDeselected.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 2 3 ).
	self assert: selecter currentIndex equals: 3.
	selecter selectAndScrollToNextDeselected.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 2 3 4 ).
	self assert: selecter currentIndex equals: 4.
	self assert: holder scrollIndex equals: 4

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectAndScrollToPrevious [

	selecter selectIndex: 2.
	selecter selectAndScrollToPrevious.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes asSet equals: #(1) asSet.
	self assert: selecter currentIndex equals: 1.
	self assert: holder scrollIndex equals: 1
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectAndScrollToPreviousDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	selecter selectAndScrollToPreviousDeselected.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 1 2 ).
	self assert: selecter currentIndex equals: 1.
	selecter selectAndScrollToPreviousDeselected.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes equals: #( 1 2 ).
	self assert: selecter currentIndex equals: 1.
	self assert: holder scrollIndex equals: 1
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes size equals: 1.
	self assert: holder selectionModel selectedIndexes first equals: 2
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectIndex2 [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes first equals: 2.
	self assert: selecter currentIndex equals: 2
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectIndexTo [

	selecter selectIndex: 2 to: 10.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes size equals: 9.
	self assert: holder selectionModel selectedIndexes asSet equals: (2 to: 10) asSet
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectIndexTo2 [

	selecter selectIndex: 2 to: 10.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 10
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectNextOnLastIndex [

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
ToSelectionModelOperatorTest >> testSelectOnlyIndex [

	selecter deselectAll.
	selecter selectAllIndexes: {2. 6. 9}.
	selecter selectOnlyIndex: 10.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes asSet equals: {10} asSet.
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectOnlyIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter selectOnlyIndexes: {10. 6. 20}.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes asSet equals: {10. 6. 20} asSet.
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectPreviousOnFirstIndex [

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
ToSelectionModelOperatorTest >> testSelectThenDeselectAll [

	selecter selectIndex: 2.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectToIndex [

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
ToSelectionModelOperatorTest >> testSelectionChanged [

	selecter selectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: selectionChanged. 

]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnDeselectAll [

	selectionChanged := false.
	selecter selectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: selectionChanged
]

{ #category : #tests }
ToSelectionModelOperatorTest >> testSelectionChangedOnDeselectAll2 [

	selectionChanged := false.
	selecter selectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	selecter deselectAll.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: selectionChanged
]
