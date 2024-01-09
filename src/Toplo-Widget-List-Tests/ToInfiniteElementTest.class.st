Class {
	#name : #ToInfiniteElementTest,
	#superclass : #ToInfiniteTest,
	#category : #'Toplo-Widget-List-Tests-Infinite'
}

{ #category : #tests }
ToInfiniteElementTest >> testEmptyInfinite [

	| l |
	l := ToInfiniteElement new.
	l fitContent.
	self assert: l data isEmpty.
	l forceLayout.
	self
		assert: l size
		equals:
		l padding left + l padding right
		@ (l padding top + l padding bottom).
	self assert: l selection selectedIndexes isEmpty
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testEmptyListAddOrRemoveNextInSelection [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.
	l fitContent.
	self assert: l data isEmpty.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection addOrRemoveNext.
	self assert: l selection currentIndex isZero
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testEmptyListAddOrRemovePreviousInSelection [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.
	l fitContent.
	self assert: l data isEmpty.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection addOrRemovePrevious.
	self assert: l selection currentIndex isZero
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testEmptyListSelectNextInSelection [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	self assert: l data isEmpty.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectNext.
	self assert: l selection currentIndex isZero.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectNext.
	self assert: l selection currentIndex isZero.
	self assert: l selection selectedIndexes isEmpty
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testEmptyListSelectPreviousInSelection [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	self assert: l data isEmpty.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectPrevious.
	self assert: l selection currentIndex isZero.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectPrevious.
	self assert: l selection currentIndex isZero.
	self assert: l selection selectedIndexes isEmpty
]

{ #category : #tests }
ToInfiniteElementTest >> testInfiniteWithOneElement [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	self assert: l data isEmpty.
	l data add: self statesOfAmerica first.
	self assert: l children size equals: 0.
	l forceLayout.
	self assert: l children size equals: 1.
	self assert: l selection notNil.
	self assert: l selection selectedIndexes isEmpty.
	self assert: l selection currentIndex isZero
	

]

{ #category : #'test selection - mode' }
ToInfiniteElementTest >> testListWithFiveDefaultSelectionMode [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selection isMultiple
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithFiveElementAddNextInSelection [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection addToSelection: 4.
	l selection addToSelection: 2.
	self assert: l selection currentIndex equals: 2.
	self assert: l selection selectedIndexes asArray equals: #( 2 4 ).
	l selection addOrRemoveNext.
	self assert: l selection currentIndex equals: 4.
	self assert: l selection selectedIndexes asArray equals: #( 2 3 4 ).
	l selection addOrRemoveNext.
	self assert: l selection currentIndex equals: 5.
	self assert: l selection selectedIndexes asArray equals: #( 2 3 4 5 )
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithFiveElementAddPreviousInSelection [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectNext.
	l selection selectNext.
	l selection addToSelection: 4.
	self assert: l selection currentIndex equals: 4.
	self assert: l selection selectedIndexes asArray equals: #( 2 4 ).
	l selection addOrRemovePrevious.
	self assert: l selection currentIndex equals: 2.
	self assert: l selection selectedIndexes asArray equals: #( 2 3 4 ).
	l selection addOrRemovePrevious.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndexes asArray equals: #( 1 2 3 4 )
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithFiveElementCherryPick [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection doCherryPickIndex: 2.
	self assert: l selection selectedIndexes asArray equals: #( 2 ).
	self assert: l selection currentIndex equals: 2.
	l selection doCherryPickIndex: 4.
	self assert: l selection selectedIndexes asArray equals: #( 2 4 ).
	self assert: l selection currentIndex equals: 4.
	l selection doCherryPickIndex: 4.
	self assert: l selection selectedIndexes asArray equals: #( 2 ).
	self assert: l selection currentIndex equals: 4.
	l selection doCherryPickIndex: 2.
	self assert: l selection selectedIndexes asArray equals: #(  ).
	self assert: l selection currentIndex equals: 2
]

{ #category : #'test selection - mode' }
ToInfiniteElementTest >> testListWithFiveFromMultipleToSingleSelectionMode [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selection isMultiple.
	l selection beSingleSelection.
	self assert: l selection isSingle.
	self assert: l selection selectedIndexes isEmpty.
	self should: [ l selection selectIndexes: #( 4 2 ) ] raise: Error.
	l selection selectOnlyIndex: 4.
	self assert: l selection selectedIndex equals: 4.
	l selection deselectIndex: 4.
	self assert: l selection selectedIndex equals: 0.
	self should: [ l selection deselectAll ] raise: Error.
	self should: [ l selection selectAll ] raise: Error
]

{ #category : #'test selection - mode' }
ToInfiniteElementTest >> testListWithFiveFromMultipleToSingleSelectionMode2 [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selection isMultiple.
	self assert: l selection selectedIndex equals: 0.

	l selection selectIndexes: #( 4 2 ).
	self assert: l selection selectedIndexes asArray equals: #( 2 4 ).

	l selection beSingleSelection.
	self assert: l selection isSingle.
	self assert: l selection selectedIndexes isEmpty.
	self should: [ l selection selectIndexes: #( 4 2 ) ] raise: Error.
	l selection selectOnlyIndex: 2.
	self assert: l selection selectedIndex equals: 2.
	l selection deselectIndex: 2.
	self assert: l selection selectedIndex equals: 0
]

{ #category : #'test selection - mode' }
ToInfiniteElementTest >> testListWithFiveFromMultipleToWithoutSelectionMode [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selection isMultiple.

	l selection beWithoutSelection.
	self assert: l selection isNone.
	self assert: l selection selectedIndexes isEmpty.
	self should: [ l selection selectIndexes: #( 4 2 ) ] raise: Error.
	self should: [ l selection selectOnlyIndex: 4 ] raise: Error.
	self should: [ l selection selectToIndex: 4 ] raise: Error.
	self should: [ l selection deselectIndex: 4 ] raise: Error.
	self should: [ l selection cherryPickIndex: 4 ] raise: Error.
	self should: [ l selection deselectAll ] raise: Error.
	self should: [ l selection selectAll ] raise: Error.
	self assert: l selection selectedIndex equals: 0
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithOneElementAddOrRemoveNextInSelection [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection addOrRemoveNext.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndex equals: 1.
	l selection addOrRemoveNext.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndex equals: 1.

]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithOneElementAddOrRemoveNextInSelection2 [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection addOrRemoveNext.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndex equals: 1.
	l selection addOrRemovePrevious.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndex equals: 1
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithOneElementAddOrRemovePreviousInSelection [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectOnlyIndex: 1.
	l selection addOrRemovePrevious.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndex equals: 1.
	l selection addOrRemovePrevious.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndex equals: 1
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithOneElementAddOrRemovePreviousInSelection2 [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectOnlyIndex: 1.
	l selection addOrRemovePrevious.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndex equals: 1.
	l selection addOrRemoveNext.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndex equals: 1
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithOneElementSelectNextInSelection [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectNext.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndex equals: 1.
	l selection selectNext.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndex equals: 1.

]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithOneElementSelectPreviousInSelection [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectPrevious.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndex equals: 1.
	l selection selectPrevious.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndex equals: 1.
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithTwoElementAddNextInSelection [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 2).
	self assert: l data size equals: 2.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection addOrRemoveNext.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndexes asArray equals: #( 1 ).
	l selection addOrRemoveNext.
	self assert: l selection currentIndex equals: 2.
	self assert: l selection selectedIndexes asArray equals: #( 1 2 ).
	l selection addOrRemoveNext.
	self assert: l selection currentIndex equals: 2.
	self assert: l selection selectedIndexes asArray equals: #( 1 2 )
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithTwoElementAddPreviousInSelection [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 2).
	self assert: l data size equals: 2.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectPrevious.
	self assert: l selection currentIndex equals: 2.
	self assert: l selection selectedIndexes asArray equals: #(2).
	l selection addOrRemovePrevious.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndexes asArray equals: #(1 2).
	l selection addOrRemovePrevious.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndexes asArray equals: #(1 2)

]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithTwoElementRemovePreviousFromSelection [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 2).
	self assert: l data size equals: 2.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection addOrRemoveNext.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndexes asArray equals: #(1).
	l selection addOrRemoveNext.
	self assert: l selection currentIndex equals: 2.
	self assert: l selection selectedIndexes asArray equals: #(1 2).
	l selection addOrRemovePrevious.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndexes asArray equals: #(1).

]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithTwoElementSelectNextInSelection [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 2).
	self assert: l data size equals: 2.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectNext.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndex equals: 1.
	l selection selectNext.
	self assert: l selection currentIndex equals: 2.
	self assert: l selection selectedIndex equals: 2.
	l selection selectNext.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndex equals: 1.

]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithTwoElementSelectPreviousInSelection [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 2).
	self assert: l data size equals: 2.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectPrevious.
	self assert: l selection currentIndex equals: 2.
	self assert: l selection selectedIndex equals: 2.
	l selection selectPrevious.
	self assert: l selection currentIndex equals: 1.
	self assert: l selection selectedIndex equals: 1.
	l selection selectPrevious.
	self assert: l selection currentIndex equals: 2.
	self assert: l selection selectedIndex equals: 2.

]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testRemoveAll [

	| l |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l children size equals: 5.
	l selection selectOnlyIndex: 2.
	l forceLayout.
	self assert: l selection selectedIndexes equals: #( 2 ).
	l data removeAll.
	l forceLayout.
	self assert: l children size equals: 0.
	l selection shiftAfterRemovingAt: 2 itemCount: 3.
	self assert: l selection selectedIndexes isEmpty
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterInsert [

	| l sp |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectOnlyIndex: 3.
	self assert: l selection currentIndex equals: 3.
	l data add: (self statesOfAmerica at: 6) afterIndex: 1.
	self assert: l selection currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	l selection shiftAfterAddingAt: 1 itemCount: 1.
	self assert: l selection currentIndex equals: 4.
	self assert: l selection selectedIndex equals: 4
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterInsert1 [

	| l sp |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectOnlyIndex: 3.
	self assert: l selection selectedIndexes equals: { 3 }.
	self assert: l selection currentIndex equals: 3.
	self assert: l children size equals: 5.
	l data addAllFirst: (self statesOfAmerica copyFrom: 6 to: 10).
	self assert: l data size equals: 10.
	self assert: l children size equals: 5.
	self assert: l selection currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	self assert: l selection currentIndex equals: 3.
	l selection shiftAfterAddingAt: 3 itemCount: 5.
	self assert: l selection selectedIndex equals: 8
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterInsert2 [

	| l sp |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectOnlyIndex: 3.
	self assert: l selection currentIndex equals: 3.
	l data add: (self statesOfAmerica at: 6) afterIndex: 3.
	self assert: l selection currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	self assert: l selection currentIndex equals: 3
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterInsert3 [

	| l sp |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectIndexes: #( 3 4 ).
	self assert: l selection selectedIndexes equals: #( 3 4 ).
	self assert: l selection currentIndex equals: 3.
	l data add: (self statesOfAmerica at: 6) afterIndex: 1.
	self assert: l selection currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	l selection shiftAfterAddingAt: 1 itemCount: 1.
	self assert: l selection currentIndex equals: 4.
	self assert: l selection selectedIndexes equals: #( 4 5 )
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterRemove [

	| l sp |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectOnlyIndex: 3.
	self assert: l selection currentIndex equals: 3.
	l data removeAt: 2.
	self assert: l selection currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	l selection shiftAfterRemovingAt: 2 itemCount: 1.
	self assert: l selection currentIndex equals: 2.
	self assert: l selection selectedIndex equals: 2
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterRemove1 [

	| l sp |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectOnlyIndex: 3.
	self assert: l selection currentIndex equals: 3.
	self assert: l children size equals: 5.
	l data removeAll.
	self assert: l selection currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	self assert: l children size equals: 0.
	self assert: l data size equals: 0.
	l selection shiftAfterRemovingAt: 1 itemCount: 5.
	self assert: l selection currentIndex equals: 0.
	self assert: l selection selectedIndex equals: 0
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterRemove2 [

	| l sp |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectOnlyIndex: 3.
	self assert: l selection currentIndex equals: 3.
	l data removeAt: 4.
	self assert: l selection currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	self assert: l selection currentIndex equals: 3
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterRemove3 [

	| l sp |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectIndexes: #( 3 4 ).
	self assert: l selection selectedIndexes equals: #( 3 4 ).
	self assert: l selection currentIndex equals: 3.
	l data removeAt: 2.
	self assert: l selection currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	l selection shiftAfterRemovingAt: 2 itemCount: 1.
	self assert: l selection currentIndex equals: 2.
	self assert: l selection selectedIndexes equals: #( 2 3 )
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterRemove4 [

	| l sp |
	l := ToInfiniteElement new.
	l selection: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selection selectedIndexes isEmpty.
	l selection selectOnlyIndex: 2.
	self assert: l selection currentIndex equals: 2.
	self assert: l selection pivot isNil.
	self assert: l selection distance isNil.
	l data removeAt: 2.
	self assert: l selection currentIndex equals: 2.
	sp := l inSpace.
	sp pulse.
	l selection shiftAfterRemovingAt: 2 itemCount: 1.
	self assert: l selection selectedIndexes isEmpty.
	self assert: l selection currentIndex equals: 0
]
