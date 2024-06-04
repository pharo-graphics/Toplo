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
	element selectionModel: ToPrimarySelectionModel new.
	selecter := ToPrimarySelecter
		            selectionModel: element selectionModel
		            operator: ToStandardSelectionModelOperator primary.
	selecter onInstalledIn: element.
	selecter enabled: false
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testDeselectAll [

	selecter selectIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: element selectionModel isEmpty
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testDeselectIndex [

	selecter selectIndex: 2.
	selecter deselectIndex: 2.
	self waitTestingSpaces.
	self assert: element selectionModel isEmpty
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testDeselectIndexes [

	selecter selectIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	selecter deselectIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: element selectionModel isEmpty 
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testDispatchSelectionChanged [

	| selChangedEvent |
	element addEventHandler: (BlEventHandler
			 on: ToListPrimarySelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).

	selecter selectIndexes: { 2. 6. 9 }.
	self waitTestingSpaces.
	self assert: selChangedEvent isNil.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.

	selChangedEvent := nil.
	" no change "
	selecter selectIndexes: { 2. 6. 9 }.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	self waitTestingSpaces.
	self assert: selChangedEvent isNil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAll [

	selecter selectAll.
	self waitTestingSpaces.
	self assert: element selectionModel isEmpty
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAll2 [

	selecter selectAll.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 0.
	self assert: element selectionModel isEmpty
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAndScrollToIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: 10.
	selecter scrollToDataSourcePosition: 10.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: element scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAndScrollToNext [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter nextSelectableIndex.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: element scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAndScrollToNextDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter nextDeselectedIndex.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	selecter selectIndex: selecter nextDeselectedIndex.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: element scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAndScrollToPrevious [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter previousSelectableIndex.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: element scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAndScrollToPreviousDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectIndex: selecter previousDeselectedIndex.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	selecter selectIndex: selecter previousDeselectedIndex.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: element scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectIndex2 [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectIndexTo [

	selecter selectIndex: 2 to: 10.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectIndexTo2 [

	selecter selectIndex: 2 to: 10.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectIndexes [

	selecter selectIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectNextOnLastIndex [

	selecter selectIndex: element itemCount.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 0.
	selecter selectIndex: selecter nextSelectableIndex.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: element scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectOnlyIndex [

	selecter deselectAll.
	selecter selectIndexes: {2. 6. 9}.
	selecter selectOnlyIndex: 10.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectOnlyIndexes [

	selecter selectIndexes: {2. 6. 9}.
	selecter selectOnlyIndexes: {10. 6. 20}.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectPreviousOnFirstIndex [

	selecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 0.
	selecter selectIndex: selecter previousSelectableIndex.
	selecter scrollToDataSourcePosition: selecter currentIndex.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: element scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectThenDeselectAll [

	selecter selectIndex: 2.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectToIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	selecter selectIndex: 2 to: 12.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	selecter selectIndex: 12 to: 2.
	self waitTestingSpaces.
	self assert: element selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0

]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectionChanged [

	selecter selectIndexes: {2}.
	self waitTestingSpaces.
	self deny: selectionChanged. 

]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll [

	selectionChanged := false.
	selecter selectIndexes: {2}.
	self waitTestingSpaces.
	selecter deselectAll.
	self waitTestingSpaces.
	self deny: selectionChanged
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll2 [

	selectionChanged := false.
	selecter selectIndexes: {2 }.
	self waitTestingSpaces.
	selecter deselectAll.
	selecter deselectAll.
	self waitTestingSpaces.
	self deny: selectionChanged
]
