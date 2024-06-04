Class {
	#name : #ToMultiSelectionModelSelecterTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'selectionChanged',
		'selecter',
		'element'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Selecter'
}

{ #category : #running }
ToMultiSelectionModelSelecterTest >> setUp [

	super setUp.
	selectionChanged := false.
	element := ToSelecterEventTargetStub new.
	element selectionModel: ToPrimarySelectionModel new.
	selecter := ToPrimarySelecter
		            selectionModel: element selectionModel
		            operator: ToPrimarySelectionModelOperator new.
	selecter onInstalledIn: element.
	selecter multiple: true
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testDeselectAll [

	selecter selectIndexes: {2. 6. 9}.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: element selectionModel isEmpty
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testDeselectIndex [

	selecter selectIndex: 2.
	selecter deselectIndex: 2.
	self waitTestingSpaces.
	self assert: element selectionModel isEmpty
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testDeselectIndexes [

	selecter selectIndexes: {2. 6. 9}.
	selecter deselectIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: element selectionModel isEmpty 
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testDispatchSelectionChanged [

	| selChangedEvent |
	element addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).
	
		selecter selectionModel deselectAll.
	selecter selectionModel selectedIndexes traceCr.
	selecter selectIndexes: { 2. 6. 9 }.
	self waitTestingSpaces.
	self assert: selChangedEvent notNil.

	selChangedEvent := nil.
	" no change "
	selecter selectIndexes: { 2. 6. 9 }.
	self waitTestingSpaces.
	self assert: selChangedEvent isNil
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAll [

	selecter selectAll.
	self waitTestingSpaces.
	self assert: element selectionModel isNotEmpty.
	self assert: selecter currentIndex equals: element selectionModel itemCount
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAndScrollToIndex [

	selecter selectIndex: 2.
	selecter selectIndex: 10.
	selecter scrollToDataSourcePosition: 10.
	self waitTestingSpaces.
	self
		assert: element selectionModel selectedIndexes asSet
		equals: #( 2 10 ) asSet.
	self assert: selecter currentIndex equals: 10.
	self assert: element scrollIndex equals: 10
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAndScrollToNext [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter nextSelectableIndex.
	self waitTestingSpaces.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self
		assert: element selectionModel selectedIndexes asSet
		equals: #( 2 3 ) asSet.
	self assert: selecter currentIndex equals: 3.
	self assert: element scrollIndex equals: 3
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAndScrollToNextDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter nextDeselectedIndex.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes equals: #( 2 3 ).
	self assert: selecter currentIndex equals: 3.
	selecter selectIndex: selecter nextDeselectedIndex.
	self waitTestingSpaces.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes equals: #( 2 3 4 ).
	self assert: selecter currentIndex equals: 4.
	self assert: element scrollIndex equals: 4
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAndScrollToPrevious [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter previousSelectableIndex.
	self waitTestingSpaces.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self
		assert: element selectionModel selectedIndexes asSet
		equals: #( 1 2 ) asSet.
	self assert: selecter currentIndex equals: 1.
	self assert: element scrollIndex equals: 1
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAndScrollToPreviousDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter previousDeselectedIndex.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes equals: #( 1 2 ).
	self assert: selecter currentIndex equals: 1.
	selecter selectIndex: selecter previousDeselectedIndex.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes equals: #( 1 2 ).
	self assert: selecter currentIndex equals: 1.
	self assert: element scrollIndex equals: 1
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes size equals: 1.
	self assert: element selectionModel selectedIndexes first equals: 2
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectIndex2 [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes first equals: 2.
	self assert: selecter currentIndex equals: 2
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectIndexTo [

	selecter selectIndex: 2 to: 10.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes size equals: 9.
	self assert: element selectionModel selectedIndexes asSet equals: (2 to: 10) asSet
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectIndexTo2 [

	selecter selectIndex: 2 to: 10.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 10
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectIndexes [

	selecter selectIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes size equals: 3.
	self assert: element selectionModel selectedIndexes equals: {2. 6. 9} 
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectNextOnLastIndex [

	selecter selectIndex: element itemCount.
	self waitTestingSpaces.
	self
		assert: selecter currentIndex
		equals: element  itemCount.
	selecter selectIndex: selecter nextSelectableIndex.
	self waitTestingSpaces.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self
		assert: element selectionModel selectedIndexes asSet
		equals: { 100. 1 } asSet.
	self assert: selecter currentIndex equals: 1.
	self assert: element scrollIndex equals: 1
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectOnlyIndex [

	selecter deselectAll.
	selecter selectIndexes: {2. 6. 9}.
	selecter selectOnlyIndex: 10.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes asSet equals: {10} asSet.
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectOnlyIndexes [

	selecter selectIndexes: {2. 6. 9}.
	selecter selectOnlyIndexes: {10. 6. 20}.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes equals: {6. 10. 20}.
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectPreviousOnFirstIndex [

	selecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 1.
	selecter selectIndex: selecter previousSelectableIndex.
	self waitTestingSpaces.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes equals: {
			1.
			element  itemCount }.
	self
		assert: selecter currentIndex
		equals: element  itemCount.
	self assert: element scrollIndex equals: element  itemCount
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectThenDeselectAll [

	selecter selectIndex: 2.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectToIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes first equals: 2.
	self assert: selecter currentIndex equals: 2.
	selecter selectIndex: 2 to: 12.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes first equals: 2.
	self assert: element selectionModel selectedIndexes last equals: 12.
	self assert: selecter currentIndex equals: 12.
	selecter selectIndex: 12 to: 2.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes first equals: 2.
	self assert: element selectionModel selectedIndexes last equals: 12.
	self assert: selecter currentIndex equals: 2

]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectionChanged [

	selectionChanged := false.
	element addEventHandlerOn: ToListPrimarySelectionChangedEvent  do: [ selectionChanged := true ].
	selecter selectIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: selectionChanged. 

]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll [

	selectionChanged := false.
	element addEventHandlerOn: ToListPrimarySelectionChangedEvent  do: [ selectionChanged := true ].
	selecter selectIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: selectionChanged
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll2 [

	selectionChanged := false.
	element addEventHandlerOn: ToListPrimarySelectionChangedEvent  do: [ selectionChanged := true ].
	selecter selectIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	selecter deselectAll.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: selectionChanged
]
