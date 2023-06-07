Class {
	#name : #ToListInfiniteElementTest,
	#superclass : #ToInfiniteTest,
	#category : #'Toplo-Tests-Widget-List'
}

{ #category : #tests }
ToListInfiniteElementTest >> testEmptyInfinite [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	self assert: l data isEmpty.
	l forceLayout.
	self assert: l size equals: (l padding left + l padding right) @ (l padding top + l padding bottom).
	self assert: l selectedIndexes isEmpty.
	self assert: l primarySelection isMultiple
]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testEmptyListAddOrRemoveNextInSelection [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	self assert: l data isEmpty.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l primarySelection addOrRemoveNext.
	self assert: l primarySelection currentIndex isZero
]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testEmptyListAddOrRemovePreviousInSelection [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	self assert: l data isEmpty.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l primarySelection addOrRemovePrevious.
	self assert: l primarySelection currentIndex isZero
]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testEmptyListSelectNextInSelection [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	self assert: l data isEmpty.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l primarySelection selectNext.
	self assert: l primarySelection currentIndex isZero.
	self assert: l selectedIndexes isEmpty.
	l primarySelection selectNext.
	self assert: l primarySelection currentIndex isZero.
	self assert: l selectedIndexes isEmpty
]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testEmptyListSelectPreviousInSelection [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	self assert: l data isEmpty.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l primarySelection selectPrevious.
	self assert: l primarySelection currentIndex isZero.
	self assert: l selectedIndexes isEmpty.
	l primarySelection selectPrevious.
	self assert: l primarySelection currentIndex isZero.
	self assert: l selectedIndexes isEmpty
]

{ #category : #tests }
ToListInfiniteElementTest >> testInfiniteWithOneElement [

	| l |
	l := ToListInfiniteElement new.
	self assert: l data isEmpty.
	l data add: self statesOfAmerica first.
	self assert: l children size equals: 0.
	l forceLayout.
	self assert: l children size equals: 1.
	self assert: l primarySelection notNil.
	self assert: l selectedIndexes isEmpty.
	self assert: l primarySelection currentIndex isZero
	

]

{ #category : #'test - selection mode' }
ToListInfiniteElementTest >> testListWithFiveDefaultSelectionMode [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l primarySelection isMultiple
]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testListWithFiveElementAddNextInSelection [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l primarySelection addToSelection: 4.
	l primarySelection addToSelection: 2.
	self assert: l primarySelection currentIndex equals: 2.
	self assert: l selectedIndexes asArray equals: #(2 4).
	l primarySelection addOrRemoveNext.
	self assert: l primarySelection currentIndex equals: 4.
	self assert: l selectedIndexes asArray equals: #(2 3 4).
	l primarySelection addOrRemoveNext.
	self assert: l primarySelection currentIndex equals: 5.
	self assert: l selectedIndexes asArray equals: #(2 3 4 5).

]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testListWithFiveElementAddPreviousInSelection [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l primarySelection selectNext.
	l primarySelection selectNext.
	l primarySelection addToSelection: 4.
	self assert: l primarySelection currentIndex equals: 4.
	self assert: l selectedIndexes asArray equals: #(2 4).
	l primarySelection addOrRemovePrevious.
	self assert: l primarySelection currentIndex equals: 2.
	self assert: l selectedIndexes asArray equals: #(2 3 4).
	l primarySelection addOrRemovePrevious.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndexes asArray equals: #(1 2 3 4).

]

{ #category : #'test - selection mode' }
ToListInfiniteElementTest >> testListWithFiveFromMultipleToNodeSelectionMode2 [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l primarySelection isMultiple.

	l primarySelection beWithoutSelection.
	self assert: l primarySelection isNone.
	self assert: l selectedIndexes isEmpty.
	self should: [ l selectIndexes: #(4 2) ] raise: Error.
	self should: [ l selectIndex: 4 ] raise: Error.
	self should: [ l selectToIndex: 4 ] raise: Error.
	self should: [ l deselectIndex: 4 ] raise: Error.
	self should: [ l cherryPickIndex: 4 ] raise: Error.
	self should: [ l deselectAll ] raise: Error.
	self should: [ l selectAll ] raise: Error.
	self assert: l selectedIndex equals: 0

	
]

{ #category : #'test - selection mode' }
ToListInfiniteElementTest >> testListWithFiveFromMultipleToSingleSelectionMode [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l primarySelection isMultiple.
	l primarySelection beSingleSelection.
	self assert: l primarySelection isSingle.
	self assert: l selectedIndexes isEmpty.
	self should: [ l selectIndexes: #(4 2) ] raise: Error.
	l selectIndex: 4.
	self assert: l selectedIndex equals: 4.
	l deselectIndex: 4.
	self assert: l selectedIndex equals: 0.
	self should: [ l cherryPickIndex: 4 ] raise: Error.
	self should: [ l deselectAll ] raise: Error.
	self should: [ l selectAll ] raise: Error.

]

{ #category : #'test - selection mode' }
ToListInfiniteElementTest >> testListWithFiveFromMultipleToSingleSelectionMode2 [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l primarySelection isMultiple.
	self assert: l selectedIndex equals: 0.

	l selectIndexes: #(4 2).
	self assert: l selectedIndexes asArray equals: #(2 4).

	l primarySelection beSingleSelection.
	self assert: l primarySelection isSingle.
	self assert: l selectedIndexes isEmpty.
	self should: [ l selectIndexes: #(4 2) ] raise: Error.
	l selectIndex: 2.
	self assert: l selectedIndex equals: 2.
	l deselectIndex: 2.
	self assert: l selectedIndex equals: 0


	
]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testListWithOneElementAddOrRemoveNextInSelection [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l primarySelection addOrRemoveNext.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndex equals: 1.
	l primarySelection addOrRemoveNext.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndex equals: 1.

]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testListWithOneElementAddOrRemoveNextInSelection2 [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l primarySelection addOrRemoveNext.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndex equals: 1.
	l primarySelection addOrRemovePrevious.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndex equals: 1.

]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testListWithOneElementAddOrRemovePreviousInSelection [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l selectIndex: 1.
	l primarySelection addOrRemovePrevious.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndex equals: 1.
	l primarySelection addOrRemovePrevious.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndex equals: 1.

]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testListWithOneElementAddOrRemovePreviousInSelection2 [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l selectIndex: 1.
	l primarySelection addOrRemovePrevious.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndex equals: 1.
	l primarySelection addOrRemoveNext.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndex equals: 1.

]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testListWithOneElementSelectNextInSelection [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l primarySelection selectNext.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndex equals: 1.
	l primarySelection selectNext.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndex equals: 1.

]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testListWithOneElementSelectPreviousInSelection [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l primarySelection selectPrevious.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndex equals: 1.
	l primarySelection selectPrevious.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndex equals: 1.
]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testListWithTwoElementAddNextInSelection [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 2).
	self assert: l data size equals: 2.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l primarySelection addOrRemoveNext.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndexes asArray equals: #(1).
	l primarySelection addOrRemoveNext.
	self assert: l primarySelection currentIndex equals: 2.
	self assert: l selectedIndexes asArray equals: #(1 2).
	l primarySelection addOrRemoveNext.
	self assert: l primarySelection currentIndex equals: 2.
	self assert: l selectedIndexes asArray equals: #(1 2).

]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testListWithTwoElementAddPreviousInSelection [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 2).
	self assert: l data size equals: 2.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l primarySelection selectPrevious.
	self assert: l primarySelection currentIndex equals: 2.
	self assert: l selectedIndexes asArray equals: #(2).
	l primarySelection addOrRemovePrevious.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndexes asArray equals: #(1 2).
	l primarySelection addOrRemovePrevious.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndexes asArray equals: #(1 2)

]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testListWithTwoElementRemovePreviousFromSelection [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 2).
	self assert: l data size equals: 2.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l primarySelection addOrRemoveNext.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndexes asArray equals: #(1).
	l primarySelection addOrRemoveNext.
	self assert: l primarySelection currentIndex equals: 2.
	self assert: l selectedIndexes asArray equals: #(1 2).
	l primarySelection addOrRemovePrevious.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndexes asArray equals: #(1).

]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testListWithTwoElementSelectNextInSelection [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 2).
	self assert: l data size equals: 2.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l primarySelection selectNext.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndex equals: 1.
	l primarySelection selectNext.
	self assert: l primarySelection currentIndex equals: 2.
	self assert: l selectedIndex equals: 2.
	l primarySelection selectNext.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndex equals: 1.

]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testListWithTwoElementSelectPreviousInSelection [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 2).
	self assert: l data size equals: 2.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l primarySelection selectPrevious.
	self assert: l primarySelection currentIndex equals: 2.
	self assert: l selectedIndex equals: 2.
	l primarySelection selectPrevious.
	self assert: l primarySelection currentIndex equals: 1.
	self assert: l selectedIndex equals: 1.
	l primarySelection selectPrevious.
	self assert: l primarySelection currentIndex equals: 2.
	self assert: l selectedIndex equals: 2.

]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testSelectionUpdatedAfterInsert [

	| l sp |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l selectIndex: 3.
	self assert: l primarySelection currentIndex equals: 3.
	l data add: (self statesOfAmerica at: 6) afterIndex: 1.
	self assert: l primarySelection currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	self assert: l primarySelection currentIndex equals: 4.
	self assert: l selectedIndex equals: 4.
	
]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testSelectionUpdatedAfterInsert1 [

	| l sp |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l selectIndex: 3.
	self assert: l primarySelection currentIndex equals: 3.
	self assert: l children size equals: 5.
	l data addAllFirst: (self statesOfAmerica copyFrom: 6 to: 10).
	self assert: l data size equals: 10.
	self assert: l primarySelection currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	self assert: l primarySelection currentIndex equals: 8.
	self assert: l selectedIndex equals: 8.
	
]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testSelectionUpdatedAfterInsert2 [

	| l sp |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	self assert: l selectedIndexes isEmpty.
	l selectIndex: 3.
	self assert: l primarySelection currentIndex equals: 3.
	l data add: (self statesOfAmerica at: 6) afterIndex: 3.
	self assert: l primarySelection currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	self assert: l primarySelection currentIndex equals: 3.
	
]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testSelectionUpdatedAfterInsert3 [

	| l sp |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l selectIndexes: #(3 4).
	self assert: l selectedIndexes equals: #(3 4).	
	self assert: l primarySelection currentIndex equals: 3.
	l data add: (self statesOfAmerica at: 6) afterIndex: 1.
	self assert: l primarySelection currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	self assert: l primarySelection currentIndex equals: 4.
	self assert: l selectedIndexes equals: #(4 5).	
]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testSelectionUpdatedAfterRemove [

	| l sp |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l selectIndex: 3.
	self assert: l primarySelection currentIndex equals: 3.
	l data removeAt: 2.
	self assert: l primarySelection currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	self assert: l primarySelection currentIndex equals: 2.
	self assert: l selectedIndex equals: 2.
	
]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testSelectionUpdatedAfterRemove1 [

	| l sp |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l selectIndex: 3.
	self assert: l primarySelection currentIndex equals: 3.
	self assert: l children size equals: 5.
	l data removeAll.
	self assert: l primarySelection currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	self assert: l children size equals: 0.
	self assert: l data size equals: 0.
	self assert: l primarySelection currentIndex equals: 0.
	self assert: l selectedIndex equals: 0.
	
]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testSelectionUpdatedAfterRemove2 [

	| l sp |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	self assert: l selectedIndexes isEmpty.
	l selectIndex: 3.
	self assert: l primarySelection currentIndex equals: 3.
	l data removeAt: 4.
	self assert: l primarySelection currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	self assert: l primarySelection currentIndex equals: 3.
	
]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testSelectionUpdatedAfterRemove3 [

	| l sp |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l selectIndexes: #(3 4).
	self assert: l selectedIndexes equals: #(3 4).	
	self assert: l primarySelection currentIndex equals: 3.
	l data removeAt: 2.
	self assert: l primarySelection currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	self assert: l primarySelection currentIndex equals: 2.
	self assert: l selectedIndexes equals: #(2 3).	
]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testSelectionUpdatedAfterRemove4 [

	| l sp |
	l := ToListInfiniteElement new.
	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l selectIndex: 2.
	self assert: l primarySelection currentIndex equals: 2.
	self assert: l primarySelection pivot isNil.
	self assert: l primarySelection distance isNil.
	l data removeAt: 2.
	self assert: l primarySelection currentIndex equals: 2.
	sp := l inSpace.
	sp pulse.
	self assert: l selectedIndexes isEmpty.
	self assert: l primarySelection currentIndex equals: 0
	
]
