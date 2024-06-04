Class {
	#name : #ToSingleSelectionModelSelecterTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'selectionChanged',
		'selecter',
		'element'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Selecter'
}

{ #category : #running }
ToSingleSelectionModelSelecterTest >> setUp [

	super setUp.
	selectionChanged := false.
	element := ToSelecterEventTargetStub new.
	element selectionModel: ToPrimarySelectionModel new.
	selecter := ToPrimarySelecter
		            selectionModel: element selectionModel
		            operator: ToPrimarySelectionModelOperator new.
	selecter onInstalledIn: element.
	selecter multiple: false
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testDeselectAll [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes equals: { 2 }.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: element selectionModel isEmpty
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
	self assert: element selectionModel selectedIndexes equals: #( 2 ).
	selecter deselectIndexes: {3. 6. 9}.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes equals: #( 2 ).
	selecter deselectIndexes: {3. 2. 9}.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes equals: #(  ).



	
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testDispatchSelectionChanged [

	| selChangedEvent |
	element addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: selChangedEvent notNil.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes equals: { 2 }.

	selChangedEvent := nil.
	" no change "
	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes equals: { 2 }.
	self waitTestingSpaces.
	self assert: selChangedEvent isNil
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAll [

	self assert: selecter currentIndex equals: 0.
	self assert: element selectionModel isEmpty
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: 10.
	self waitTestingSpaces.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes equals: #( 10 ).
	self assert: selecter currentIndex equals: 10.
	self assert: element scrollIndex equals: 10
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToNext [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 2.

	selecter selectIndex: selecter nextSelectableIndex.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 3.

	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self
		assert: element selectionModel selectedIndexes asSet
		equals: #( 3 ) asSet.
	self assert: selecter currentIndex equals: 3.
	self assert: element scrollIndex equals: 3
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToNextDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter nextDeselectedIndex.
	self waitTestingSpaces.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes equals: #( 3 ).
	self assert: selecter currentIndex equals: 3.
	selecter selectIndex: selecter nextDeselectedIndex.
	self waitTestingSpaces.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes equals: #( 4 ).
	self assert: selecter currentIndex equals: 4.
	self assert: element scrollIndex equals: 4
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToPrevious [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter previousSelectableIndex.
	self waitTestingSpaces.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self
		assert: element selectionModel selectedIndexes asSet
		equals: #( 1 ) asSet.
	self assert: selecter currentIndex equals: 1.
	self waitTestingSpaces.
	self assert: element scrollIndex equals: 1
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToPreviousDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter previousDeselectedIndex.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes equals: #( 1 ).
	self assert: selecter currentIndex equals: 1.
	selecter selectIndex: selecter previousDeselectedIndex.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes equals: #( 1 ).
	self assert: selecter currentIndex equals: 1.
	self assert: element scrollIndex equals: 1
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes size equals: 1.
	self assert: element selectionModel selectedIndexes first equals: 2
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectIndex2 [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes first equals: 2.
	self assert: selecter currentIndex equals: 2
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectIndexTo [

	self should: [selecter selectIndex: 2 to: 4] raise: Error.
	self should: [selecter selectIndex: 4 to: 2] raise: Error.
	selecter selectIndex: 2 to: 2.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes  equals: {2} .
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectIndexes [

	self should: [selecter selectIndexes: {2. 6. 9} ] raise: Error

]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectNextOnLastIndex [

	selecter selectIndex: element itemCount.
	self
		assert: selecter currentIndex
		equals: element itemCount.
	selecter selectIndex: selecter nextSelectableIndex.
	self waitTestingSpaces.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self
		assert: element selectionModel selectedIndexes asSet
		equals: { 1 } asSet.
	self assert: selecter currentIndex equals: 1.
	self assert: element scrollIndex equals: 1
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectOnlyIndex [

	selecter deselectAll.
	selecter selectIndex: 2.
	selecter selectOnlyIndex: 10.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes asSet equals: {10} asSet.
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectOnlyIndexes [

	self should: [selecter selectIndexes: {2. 6. 9} ] raise: Error
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectPreviousOnFirstIndex [

	selecter selectIndex: 1.
	self assert: selecter currentIndex equals: 1.
	selecter selectIndex: selecter previousSelectableIndex.
	self waitTestingSpaces.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self
		assert: element selectionModel selectedIndexes asSet
		equals: { element itemCount } asSet.
	self
		assert: selecter currentIndex
		equals: element itemCount.
	self assert: element scrollIndex equals: element itemCount
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectThenDeselectAll [

	selecter selectIndex: 2.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectToIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes first equals: 2.
	self assert: selecter currentIndex equals: 2.
	self should: [selecter selectIndex: 2 to: 12 ] raise: Error
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectionChanged [

	selectionChanged := false.
	element addEventHandlerOn: ToListPrimarySelectionChangedEvent  do: [ selectionChanged := true ].
	selecter selectIndex: 2.
	
	self assert: selectionChanged. 

]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll [

	selectionChanged := false.
	element
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ selectionChanged := true ].
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
