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
	space root addChild: element.
	element selectionModel: ToPrimarySelectionModel new.
	selecter := ToCompositeSelecter new
		            selectionModel: element selectionModel;
		            selectionChangedEventClass:
			            ToListPrimarySelectionChangedEvent;
		            yourself.
	selecter commandApplicationStrategy: BlQueueBasedCommandApplicationStrategy new.
	selecter onInstalledIn: element.
	selecter multiple: false
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testDeselectAll [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	self assert: element selectionModel selectedIndexes equals: { 2 }.

	space deferAndSettle: [ selecter deselectAll ].
	self assert: element selectionModel isEmpty
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testDeselectIndex [

	selecter selectIndex: 2.
	selecter deselectIndex: 2
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testDeselectIndexes [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	self assert: element selectionModel selectedIndexes equals: #( 2 ).

	space deferAndSettle: [ selecter deselectIndexes: {3. 6. 9} ].
	self assert: element selectionModel selectedIndexes equals: #( 2 ).

	space deferAndSettle: [ selecter deselectIndexes: {3. 2. 9} ].
	self assert: element selectionModel selectedIndexes equals: #(  ).



	
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testDispatchSelectionChanged [

	| selChangedEvent |
	element addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).

	space deferAndSettle: [ selecter selectIndex: 2 ].
	self assert: selChangedEvent notNil.
	self assert: element selectionModel selectedIndexes equals: { 2 }.

	selChangedEvent := nil.
	" no change "
	space deferAndSettle: [ selecter selectIndex: 2 ].
	self assert: element selectionModel selectedIndexes equals: { 2 }.
	self assert: selChangedEvent isNil
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAll [

	self assert: selecter currentIndex equals: 0.
	self assert: element selectionModel isEmpty
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToIndex [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	space deferAndSettle: [ selecter selectIndex: 10 ].
	space deferAndSettle: [ selecter scrollToDataSourcePosition: selecter currentIndex ].
	self assert: element selectionModel selectedIndexes equals: #( 10 ).
	self assert: selecter currentIndex equals: 10.
	self assert: element scrollIndex equals: 10
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToNext [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	self assert: selecter currentIndex equals: 2.

	space deferAndSettle: [ selecter selectIndex: selecter nextSelectableIndex ].
	self assert: selecter currentIndex equals: 3.

	space deferAndSettle: [ selecter scrollToDataSourcePosition: selecter currentIndex ].
	self
		assert: element selectionModel selectedIndexes asSet
		equals: #( 3 ) asSet.
	self assert: selecter currentIndex equals: 3.
	self assert: element scrollIndex equals: 3
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToNextDeselected [

	space deferAndSettle: [
		selecter deselectAll.
		selecter selectIndex: 2 ].
	space deferAndSettle: [ selecter selectIndex: selecter nextDeselectedIndex ].
	space deferAndSettle: [ selecter scrollToDataSourcePosition: selecter currentIndex ].
	self assert: element selectionModel selectedIndexes equals: #( 3 ).
	self assert: selecter currentIndex equals: 3.

	space deferAndSettle: [ selecter selectIndex: selecter nextDeselectedIndex ].
	space deferAndSettle: [ selecter scrollToDataSourcePosition: selecter currentIndex ].
	self assert: element selectionModel selectedIndexes equals: #( 4 ).
	self assert: selecter currentIndex equals: 4.
	self assert: element scrollIndex equals: 4
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToPrevious [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	space deferAndSettle: [ selecter selectIndex: selecter previousSelectableIndex ].
	space deferAndSettle: [ selecter scrollToDataSourcePosition: selecter currentIndex ].
	self
		assert: element selectionModel selectedIndexes asSet
		equals: #( 1 ) asSet.
	self assert: selecter currentIndex equals: 1.
	self assert: element scrollIndex equals: 1
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectAndScrollToPreviousDeselected [

	space deferAndSettle: [
		selecter deselectAll.
		selecter selectIndex: 2 ].
	space deferAndSettle: [
		selecter selectIndex: selecter previousDeselectedIndex.
		selecter scrollToDataSourcePosition: selecter currentIndex ].
	self assert: element selectionModel selectedIndexes equals: #( 1 ).
	self assert: selecter currentIndex equals: 1.

	space deferAndSettle: [
		selecter selectIndex: selecter previousDeselectedIndex.
		selecter scrollToDataSourcePosition: selecter currentIndex ].
	self assert: element selectionModel selectedIndexes equals: #( 1 ).
	self assert: selecter currentIndex equals: 1.
	self assert: element scrollIndex equals: 1
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectIndex [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	self assert: element selectionModel selectedIndexes size equals: 1.
	self assert: element selectionModel selectedIndexes first equals: 2
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectIndex2 [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	self assert: element selectionModel selectedIndexes first equals: 2.
	self assert: selecter currentIndex equals: 2
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectIndexTo [

	self should: [selecter selectIndex: 2 to: 4] raise: Error.
	self should: [selecter selectIndex: 4 to: 2] raise: Error.
	space deferAndSettle: [ selecter selectIndex: 2 to: 2 ].
	self assert: element selectionModel selectedIndexes  equals: {2} .
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectIndexes [

	self should: [selecter selectIndexes: {2. 6. 9} ] raise: Error

]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectNextOnLastIndex [

	space deferAndSettle: [ selecter selectIndex: element itemCount ].
	self
		assert: selecter currentIndex
		equals: element itemCount.

	space deferAndSettle: [ selecter selectIndex: selecter nextSelectableIndex ].
	space deferAndSettle: [ selecter scrollToDataSourcePosition: selecter currentIndex ].
	self
		assert: element selectionModel selectedIndexes asSet
		equals: { 1 } asSet.
	self assert: selecter currentIndex equals: 1.
	self assert: element scrollIndex equals: 1
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectOnlyIndex [

	space deferAndSettle: [
		selecter deselectAll.
		selecter selectIndex: 2.
		selecter selectOnlyIndex: 10 ].
	self assert: element selectionModel selectedIndexes asSet equals: {10} asSet.
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectOnlyIndexes [

	self should: [selecter selectIndexes: {2. 6. 9} ] raise: Error
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectPreviousOnFirstIndex [

	space deferAndSettle: [ selecter selectIndex: 1 ].
	self assert: selecter currentIndex equals: 1.

	space deferAndSettle: [ selecter selectIndex: selecter previousSelectableIndex ].
	space deferAndSettle: [ selecter scrollToDataSourcePosition: selecter currentIndex ].
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

	space deferAndSettle: [
		selecter selectIndex: 2.
		selecter deselectAll ].
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectToIndex [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	self assert: element selectionModel selectedIndexes first equals: 2.
	self assert: selecter currentIndex equals: 2.
	self should: [selecter selectIndex: 2 to: 12 ] raise: Error
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectionChanged [

	selectionChanged := false.
	element addEventHandlerOn: ToListPrimarySelectionChangedEvent  do: [ selectionChanged := true ].
	space deferAndSettle: [ selecter selectIndex: 2 ].
	
	self assert: selectionChanged. 
]

{ #category : #tests }
ToSingleSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll [

	selectionChanged := false.
	element
		addEventHandlerOn: ToListPrimarySelectionChangedEvent
		do: [ selectionChanged := true ].
	space deferAndSettle: [ selecter selectIndex: 2 ].
	self assert: selectionChanged.
	selectionChanged := false.
	space deferAndSettle: [ selecter deselectAll ].
	self assert: selectionChanged.
	selectionChanged := false.
	space deferAndSettle: [ selecter deselectAll ].
	self deny: selectionChanged
]
