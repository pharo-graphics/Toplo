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
	space root addChild: element.
	element selectionModel: ToPrimarySelectionModel new.
	selecter := ToCompositeSelecter new
		            selectionModel: element selectionModel;
		            selectionChangedEventClass:
			            ToListPrimarySelectionChangedEvent;
		            yourself.
	selecter commandApplicationStrategy: BlQueueBasedCommandApplicationStrategy new.
	selecter onInstalledIn: element.
	selecter multiple: true
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testDeselectAll [

	space deferAndSettle: [
		selecter selectIndexes: {2. 6. 9}.
		selecter deselectAll ].
	self assert: element selectionModel isEmpty
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testDeselectIndex [

	space deferAndSettle: [
		selecter selectIndex: 2.
		selecter deselectIndex: 2 ].
	self assert: element selectionModel isEmpty
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testDeselectIndexes [

	space deferAndSettle: [
		selecter selectIndexes: {2. 6. 9}.
		selecter deselectIndexes: {2. 6. 9} ].
	self assert: element selectionModel isEmpty 
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testDispatchSelectionChanged [

	| selChangedEvent |
	element addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).

	space deferAndSettle: [
		selecter selectionModel deselectAll.
		selecter selectIndexes: { 2. 6. 9 } ].
	self assert: selChangedEvent notNil.

	selChangedEvent := nil.
	" no change "
	space deferAndSettle: [ selecter selectIndexes: { 2. 6. 9 } ].
	self assert: selChangedEvent isNil
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAll [

	space deferAndSettle: [ selecter selectAll ].
	self assert: element selectionModel isNotEmpty.
	self assert: selecter currentIndex equals: element selectionModel itemCount
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAndScrollToIndex [

	space deferAndSettle: [
		selecter selectIndex: 2.
		selecter selectIndex: 10.
		selecter scrollToDataSourcePosition: 10 ].
	self
		assert: element selectionModel selectedIndexes asSet
		equals: #( 2 10 ) asSet.
	self assert: selecter currentIndex equals: 10.
	self assert: element scrollIndex equals: 10
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAndScrollToNext [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	space deferAndSettle: [ selecter selectIndex: selecter nextSelectableIndex ].
	space deferAndSettle: [ selecter scrollToDataSourcePosition: selecter currentIndex ].
	self
		assert: element selectionModel selectedIndexes asSet
		equals: #( 2 3 ) asSet.
	self assert: selecter currentIndex equals: 3.
	self assert: element scrollIndex equals: 3
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAndScrollToNextDeselected [

	space deferAndSettle: [
		selecter deselectAll.
		selecter selectIndex: 2 ].
	space deferAndSettle: [
		selecter selectIndex: selecter nextDeselectedIndex.
		selecter scrollToDataSourcePosition: selecter currentIndex ].
	self assert: element selectionModel selectedIndexes equals: #( 2 3 ).
	self assert: selecter currentIndex equals: 3.

	space deferAndSettle: [ selecter selectIndex: selecter nextDeselectedIndex ].
	space deferAndSettle: [ selecter scrollToDataSourcePosition: selecter currentIndex ].
	self assert: element selectionModel selectedIndexes equals: #( 2 3 4 ).
	self assert: selecter currentIndex equals: 4.
	self assert: element scrollIndex equals: 4
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAndScrollToPrevious [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	space deferAndSettle: [ selecter selectIndex: selecter previousSelectableIndex ].
	space deferAndSettle: [ selecter scrollToDataSourcePosition: selecter currentIndex ].
	self
		assert: element selectionModel selectedIndexes asSet
		equals: #( 1 2 ) asSet.
	self assert: selecter currentIndex equals: 1.
	self assert: element scrollIndex equals: 1
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectAndScrollToPreviousDeselected [

	space deferAndSettle: [
		selecter deselectAll.
		selecter selectIndex: 2 ].
	space deferAndSettle: [
		selecter selectIndex: selecter previousDeselectedIndex.
		selecter scrollToDataSourcePosition: selecter currentIndex ].
	self assert: element selectionModel selectedIndexes equals: #( 1 2 ).
	self assert: selecter currentIndex equals: 1.

	space deferAndSettle: [
		selecter selectIndex: selecter previousDeselectedIndex.
		selecter scrollToDataSourcePosition: selecter currentIndex ].
	self assert: element selectionModel selectedIndexes equals: #( 1 2 ).
	self assert: selecter currentIndex equals: 1.
	self assert: element scrollIndex equals: 1
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectIndex [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	self assert: element selectionModel selectedIndexes size equals: 1.
	self assert: element selectionModel selectedIndexes first equals: 2
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectIndex2 [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	self assert: element selectionModel selectedIndexes first equals: 2.
	self assert: selecter currentIndex equals: 2
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectIndexTo [

	space deferAndSettle: [ selecter selectIndex: 2 to: 10 ].
	self assert: element selectionModel selectedIndexes size equals: 9.
	self assert: element selectionModel selectedIndexes asSet equals: (2 to: 10) asSet
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectIndexTo2 [

	space deferAndSettle: [ selecter selectIndex: 2 to: 10 ].
	self assert: selecter currentIndex equals: 10
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectIndexes [

	space deferAndSettle: [ selecter selectIndexes: {2. 6. 9} ].
	self assert: element selectionModel selectedIndexes size equals: 3.
	self assert: element selectionModel selectedIndexes equals: {2. 6. 9} 
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectNextOnLastIndex [

	space deferAndSettle: [ selecter selectIndex: element itemCount ].
	self
		assert: selecter currentIndex
		equals: element  itemCount.

	space deferAndSettle: [ selecter selectIndex: selecter nextSelectableIndex ].
	space deferAndSettle: [ selecter scrollToDataSourcePosition: selecter currentIndex ].
	self
		assert: element selectionModel selectedIndexes asSet
		equals: { 100. 1 } asSet.
	self assert: selecter currentIndex equals: 1.
	self assert: element scrollIndex equals: 1
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectOnlyIndex [

	space deferAndSettle: [
		selecter deselectAll.
		selecter selectIndexes: {2. 6. 9}.
		selecter selectOnlyIndex: 10 ].
	self assert: element selectionModel selectedIndexes asSet equals: {10} asSet.
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectOnlyIndexes [

	space deferAndSettle: [
		selecter selectIndexes: {2. 6. 9}.
		selecter selectOnlyIndexes: {10. 6. 20} ].
	self assert: element selectionModel selectedIndexes equals: {6. 10. 20}.
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectPreviousOnFirstIndex [

	space deferAndSettle: [ selecter selectIndex: 1 ].
	self assert: selecter currentIndex equals: 1.

	space deferAndSettle: [ selecter selectIndex: selecter previousSelectableIndex ].
	space deferAndSettle: [ selecter scrollToDataSourcePosition: selecter currentIndex ].
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

	space deferAndSettle: [
		selecter selectIndex: 2.
		selecter deselectAll ].
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectToIndex [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	self assert: element selectionModel selectedIndexes first equals: 2.
	self assert: selecter currentIndex equals: 2.

	space deferAndSettle: [ selecter selectIndex: 2 to: 12 ].
	self assert: element selectionModel selectedIndexes first equals: 2.
	self assert: element selectionModel selectedIndexes last equals: 12.
	self assert: selecter currentIndex equals: 12.

	space deferAndSettle: [ selecter selectIndex: 12 to: 2 ].
	self assert: element selectionModel selectedIndexes first equals: 2.
	self assert: element selectionModel selectedIndexes last equals: 12.
	self assert: selecter currentIndex equals: 2
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectionChanged [

	selectionChanged := false.
	element addEventHandlerOn: ToListPrimarySelectionChangedEvent  do: [ selectionChanged := true ].
	space deferAndSettle: [ selecter selectIndexes: {2. 6. 9} ].
	self assert: selectionChanged. 
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll [

	selectionChanged := false.
	element addEventHandlerOn: ToListPrimarySelectionChangedEvent  do: [ selectionChanged := true ].
	space deferAndSettle: [ selecter selectIndexes: {2. 6. 9} ].
	space deferAndSettle: [ selecter deselectAll ].
	self assert: selectionChanged
]

{ #category : #tests }
ToMultiSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll2 [

	selectionChanged := false.
	element addEventHandlerOn: ToListPrimarySelectionChangedEvent  do: [ selectionChanged := true ].
	space deferAndSettle: [ selecter selectIndexes: {2. 6. 9} ].
	space deferAndSettle: [
		selecter deselectAll.
		selecter deselectAll ].
	self assert: selectionChanged
]
