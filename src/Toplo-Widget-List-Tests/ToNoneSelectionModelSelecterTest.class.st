Class {
	#name : #ToNoneSelectionModelSelecterTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'selectionChanged',
		'selecter',
		'element'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Selecter'
}

{ #category : #running }
ToNoneSelectionModelSelecterTest >> setUp [

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
	selecter onInstalledIn: element.
	selecter enabled: false
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testDeselectAll [

	space deferAndSettle: [ selecter selectIndexes: {2. 6. 9} ].
	self assert: element selectionModel selectedIndexes isEmpty.

	space deferAndSettle: [ selecter deselectAll ].
	self assert: element selectionModel isEmpty
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testDeselectIndex [

	space deferAndSettle: [
		selecter selectIndex: 2.
		selecter deselectIndex: 2 ].
	self assert: element selectionModel isEmpty
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testDeselectIndexes [

	space deferAndSettle: [ selecter selectIndexes: {2. 6. 9} ].
	self assert: element selectionModel selectedIndexes isEmpty.

	space deferAndSettle: [ selecter deselectIndexes: {2. 6. 9} ].
	self assert: element selectionModel isEmpty 
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testDispatchSelectionChanged [

	| selChangedEvent |
	element addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).

	space deferAndSettle: [ selecter selectIndexes: { 2. 6. 9 } ].
	self assert: selChangedEvent isNil.
	self assert: element selectionModel selectedIndexes isEmpty.

	selChangedEvent := nil.
	" no change "
	space deferAndSettle: [ selecter selectIndexes: { 2. 6. 9 } ].
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selChangedEvent isNil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAll [

	space deferAndSettle: [ selecter selectAll ].
	self assert: element selectionModel isEmpty
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAll2 [

	space deferAndSettle: [ selecter selectAll ].
	self assert: selecter currentIndex equals: 0.
	self assert: element selectionModel isEmpty
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAndScrollToIndex [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	space deferAndSettle: [
		selecter selectIndex: 10.
		selecter scrollToDataSourcePosition: 10 ].
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: element scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAndScrollToNext [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	space deferAndSettle: [
		selecter selectIndex: selecter nextSelectableIndex.
		selecter scrollToDataSourcePosition: selecter currentIndex ].
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: element scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAndScrollToNextDeselected [

	space deferAndSettle: [
		selecter deselectAll.
		selecter selectIndex: 2 ].
	space deferAndSettle: [
		selecter selectIndex: selecter nextDeselectedIndex.
		selecter scrollToDataSourcePosition: selecter currentIndex ].
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.

	space deferAndSettle: [
		selecter selectIndex: selecter nextDeselectedIndex.
		selecter scrollToDataSourcePosition: selecter currentIndex ].
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: element scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAndScrollToPrevious [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	space deferAndSettle: [
		selecter selectIndex: selecter previousSelectableIndex.
		selecter scrollToDataSourcePosition: selecter currentIndex ].
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: element scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAndScrollToPreviousDeselected [

	space deferAndSettle: [
		selecter deselectAll.
		selecter selectIndex: 2 ].
	space deferAndSettle: [
		selecter selectIndex: selecter previousDeselectedIndex.
		selecter scrollToDataSourcePosition: selecter currentIndex ].
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.

	space deferAndSettle: [
		selecter selectIndex: selecter previousDeselectedIndex.
		selecter scrollToDataSourcePosition: selecter currentIndex ].
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: element scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectIndex [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	self assert: element selectionModel selectedIndexes isEmpty
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectIndex2 [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectIndexTo [

	space deferAndSettle: [ selecter selectIndex: 2 to: 10 ].
	self assert: element selectionModel selectedIndexes isEmpty
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectIndexTo2 [

	space deferAndSettle: [ selecter selectIndex: 2 to: 10 ].
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectIndexes [

	space deferAndSettle: [ selecter selectIndexes: {2. 6. 9} ].
	self assert: element selectionModel selectedIndexes isEmpty.
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectNextOnLastIndex [

	space deferAndSettle: [ selecter selectIndex: element itemCount ].
	self assert: selecter currentIndex equals: 0.

	space deferAndSettle: [
		selecter selectIndex: selecter nextSelectableIndex.
		selecter scrollToDataSourcePosition: selecter currentIndex ].
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: element scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectOnlyIndex [

	space deferAndSettle: [
		selecter deselectAll.
		selecter selectIndexes: {2. 6. 9}.
		selecter selectOnlyIndex: 10 ].
	self assert: element selectionModel selectedIndexes isEmpty.
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectOnlyIndexes [

	space deferAndSettle: [
		selecter selectIndexes: {2. 6. 9}.
		selecter selectOnlyIndexes: {10. 6. 20} ].
	self assert: element selectionModel selectedIndexes isEmpty.
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectPreviousOnFirstIndex [

	space deferAndSettle: [ selecter selectIndex: 1 ].
	self assert: selecter currentIndex equals: 0.

	space deferAndSettle: [
		selecter selectIndex: selecter previousSelectableIndex.
		selecter scrollToDataSourcePosition: selecter currentIndex ].
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: element scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectThenDeselectAll [

	space deferAndSettle: [
		selecter selectIndex: 2.
		selecter deselectAll ].
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectToIndex [

	space deferAndSettle: [ selecter selectIndex: 2 ].
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.

	space deferAndSettle: [ selecter selectIndex: 2 to: 12 ].
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.

	space deferAndSettle: [ selecter selectIndex: 12 to: 2 ].
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectionChanged [

	space deferAndSettle: [ selecter selectIndexes: {2} ].
	self deny: selectionChanged. 
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll [

	selectionChanged := false.
	space deferAndSettle: [ selecter selectIndexes: {2} ].
	space deferAndSettle: [ selecter deselectAll ].
	self deny: selectionChanged
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll2 [

	selectionChanged := false.
	space deferAndSettle: [ selecter selectIndexes: {2 } ].
	space deferAndSettle: [
		selecter deselectAll.
		selecter deselectAll ].
	self deny: selectionChanged
]
