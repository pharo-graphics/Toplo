Class {
	#name : #ToInfiniteElementTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Widget-List-Tests-Infinite'
}

{ #category : #accessing }
ToInfiniteElementTest >> statesOfAmerica [

	^ { #Alabama. #Alaska. #Arizona. #Arkansas. #California. #Colorado.
		#Connecticut. #Delaware. #Florida. #Georgia. #Hawaii. #Idaho. #'Illinois Indiana'.
		#Iowa. #Kansas. #Kentucky. #Louisiana. #Maine. #Maryland. #Massachusetts.
		#Michigan. #Minnesota. #Mississippi. #Missouri. #Montana. #Nebraska.
		#Nevada. #'New Hampshire'. #'New Jersey'. #'New Mexico'.
		#'New York'. #'North Carolina'. #'North Dakota'. #Ohio. #Oklahoma.
		#Oregon. #'Pennsylvania Rhode Island'. #'South Carolina'.
		#'South Dakota'. #Tennessee. #Texas. #Utah. #Vermont. #Virginia.
		#Washington. #'West Virginia'. #Wisconsin. #Wyoming }.
]

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
	self assert: l selectionStrategy selectedIndexes isEmpty
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testEmptyListAddOrRemoveNextInSelection [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.
	l fitContent.
	self assert: l data isEmpty.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy addOrRemoveNext.
	self assert: l selectionStrategy currentIndex isZero
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testEmptyListAddOrRemovePreviousInSelection [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.
	l fitContent.
	self assert: l data isEmpty.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy addOrRemovePrevious.
	self assert: l selectionStrategy currentIndex isZero
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testEmptyListSelectNextInSelection [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	self assert: l data isEmpty.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectNext.
	self assert: l selectionStrategy currentIndex isZero.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectNext.
	self assert: l selectionStrategy currentIndex isZero.
	self assert: l selectionStrategy selectedIndexes isEmpty
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testEmptyListSelectPreviousInSelection [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	self assert: l data isEmpty.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectPrevious.
	self assert: l selectionStrategy currentIndex isZero.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectPrevious.
	self assert: l selectionStrategy currentIndex isZero.
	self assert: l selectionStrategy selectedIndexes isEmpty
]

{ #category : #tests }
ToInfiniteElementTest >> testInfiniteWithOneElement [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	self assert: l data isEmpty.
	l data add: self statesOfAmerica first.
	self assert: l children size equals: 0.
	l forceLayout.
	self assert: l children size equals: 1.
	self assert: l selectionStrategy notNil.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	self assert: l selectionStrategy currentIndex isZero
]

{ #category : #'test selection - mode' }
ToInfiniteElementTest >> testListWithFiveDefaultSelectionMode [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectionStrategy isMultiple
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithFiveElementAddNextInSelection [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy doSelectIndex: 4.
	l selectionStrategy doSelectIndex: 2.
	self assert: l selectionStrategy currentIndex equals: 2.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 2 4 ).
	l selectionStrategy addOrRemoveNext.
	self assert: l selectionStrategy currentIndex equals: 4.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 2 3 4 ).
	l selectionStrategy addOrRemoveNext.
	self assert: l selectionStrategy currentIndex equals: 5.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 2 3 4 5 )
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithFiveElementAddPreviousInSelection [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectNext.
	l selectionStrategy selectNext.
	l selectionStrategy doSelectIndex: 4.
	self assert: l selectionStrategy currentIndex equals: 4.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 2 4 ).
	l selectionStrategy addOrRemovePrevious.
	self assert: l selectionStrategy currentIndex equals: 2.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 2 3 4 ).
	l selectionStrategy addOrRemovePrevious.
	self assert: l selectionStrategy currentIndex equals: 1.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 1 2 3 4 )
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithFiveElementCherryPick [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy doCherryPickIndex: 2.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 2 ).
	self assert: l selectionStrategy currentIndex equals: 2.
	l selectionStrategy doCherryPickIndex: 4.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 2 4 ).
	self assert: l selectionStrategy currentIndex equals: 4.
	l selectionStrategy doCherryPickIndex: 4.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 2 ).
	self assert: l selectionStrategy currentIndex equals: 4.
	l selectionStrategy doCherryPickIndex: 2.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #(  ).
	self assert: l selectionStrategy currentIndex equals: 2
]

{ #category : #'test selection - mode' }
ToInfiniteElementTest >> testListWithFiveFromMultipleToSingleSelectionMode [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectionStrategy isMultiple.
	l selectionStrategy beSingleSelection.
	self assert: l selectionStrategy isSingle.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	self
		should: [ l selectionStrategy selectIndexes: #( 4 2 ) ]
		raise: Error.
	l selectionStrategy selectOnlyIndex: 4.
	self assert: l selectionStrategy selectedIndex equals: 4.
	l selectionStrategy deselectIndex: 4.
	self assert: l selectionStrategy selectedIndex equals: 0.
	self should: [ l selectionStrategy deselectAll ] raise: Error.
	self should: [ l selectionStrategy selectAll ] raise: Error
]

{ #category : #'test selection - mode' }
ToInfiniteElementTest >> testListWithFiveFromMultipleToSingleSelectionMode2 [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectionStrategy isMultiple.
	self assert: l selectionStrategy selectedIndex equals: 0.

	l selectionStrategy selectIndexes: #( 4 2 ).
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 2 4 ).

	l selectionStrategy beSingleSelection.
	self assert: l selectionStrategy isSingle.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	self
		should: [ l selectionStrategy selectIndexes: #( 4 2 ) ]
		raise: Error.
	l selectionStrategy selectOnlyIndex: 2.
	self assert: l selectionStrategy selectedIndex equals: 2.
	l selectionStrategy deselectIndex: 2.
	self assert: l selectionStrategy selectedIndex equals: 0
]

{ #category : #'test selection - mode' }
ToInfiniteElementTest >> testListWithFiveFromMultipleToWithoutSelectionMode [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectionStrategy isMultiple.

	l selectionStrategy beWithoutSelection.
	self assert: l selectionStrategy isNone.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	self
		should: [ l selectionStrategy selectIndexes: #( 4 2 ) ]
		raise: Error.
	self should: [ l selectionStrategy selectOnlyIndex: 4 ] raise: Error.
	self should: [ l selectionStrategy selectToIndex: 4 ] raise: Error.
	self should: [ l selectionStrategy deselectIndex: 4 ] raise: Error.
	self should: [ l selectionStrategy cherryPickIndex: 4 ] raise: Error.
	self should: [ l selectionStrategy deselectAll ] raise: Error.
	self should: [ l selectionStrategy selectAll ] raise: Error.
	self assert: l selectionStrategy selectedIndex equals: 0
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithOneElementAddOrRemoveNextInSelection [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy addOrRemoveNext.
	self assert: l selectionStrategy currentIndex equals: 1.
	self assert: l selectionStrategy selectedIndex equals: 1.
	l selectionStrategy addOrRemoveNext.
	self assert: l selectionStrategy currentIndex equals: 1.
	self assert: l selectionStrategy selectedIndex equals: 1
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithOneElementAddOrRemoveNextInSelection2 [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy addOrRemoveNext.
	self assert: l selectionStrategy currentIndex equals: 1.
	self assert: l selectionStrategy selectedIndex equals: 1.
	l selectionStrategy addOrRemovePrevious.
	self assert: l selectionStrategy currentIndex equals: 1.
	self assert: l selectionStrategy selectedIndex equals: 1
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithOneElementAddOrRemovePreviousInSelection [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectOnlyIndex: 1.
	l selectionStrategy addOrRemovePrevious.
	self assert: l selectionStrategy currentIndex equals: 1.
	self assert: l selectionStrategy selectedIndex equals: 1.
	l selectionStrategy addOrRemovePrevious.
	self assert: l selectionStrategy currentIndex equals: 1.
	self assert: l selectionStrategy selectedIndex equals: 1
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithOneElementAddOrRemovePreviousInSelection2 [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectOnlyIndex: 1.
	l selectionStrategy addOrRemovePrevious.
	self assert: l selectionStrategy currentIndex equals: 1.
	self assert: l selectionStrategy selectedIndex equals: 1.
	l selectionStrategy addOrRemoveNext.
	self assert: l selectionStrategy currentIndex equals: 1.
	self assert: l selectionStrategy selectedIndex equals: 1
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithOneElementSelectNextInSelection [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectNext.
	self assert: l selectionStrategy currentIndex equals: 1.
	self assert: l selectionStrategy selectedIndex equals: 1.
	l selectionStrategy selectNext.
	self assert: l selectionStrategy currentIndex equals: 1.
	self assert: l selectionStrategy selectedIndex equals: 1
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithOneElementSelectPreviousInSelection [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data add: self statesOfAmerica first.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectPrevious.
	self assert: l selectionStrategy currentIndex equals: 1.
	self assert: l selectionStrategy selectedIndex equals: 1.
	l selectionStrategy selectPrevious.
	self assert: l selectionStrategy currentIndex equals: 1.
	self assert: l selectionStrategy selectedIndex equals: 1
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithTwoElementAddNextInSelection [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 2).
	self assert: l data size equals: 2.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy addOrRemoveNext.
	self assert: l selectionStrategy currentIndex equals: 1.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 1 ).
	l selectionStrategy addOrRemoveNext.
	self assert: l selectionStrategy currentIndex equals: 2.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 1 2 ).
	l selectionStrategy addOrRemoveNext.
	self assert: l selectionStrategy currentIndex equals: 2.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 1 2 )
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithTwoElementAddPreviousInSelection [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 2).
	self assert: l data size equals: 2.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectPrevious.
	self assert: l selectionStrategy currentIndex equals: 2.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 2 ).
	l selectionStrategy addOrRemovePrevious.
	self assert: l selectionStrategy currentIndex equals: 1.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 1 2 ).
	l selectionStrategy addOrRemovePrevious.
	self assert: l selectionStrategy currentIndex equals: 1.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 1 2 )
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithTwoElementRemovePreviousFromSelection [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 2).
	self assert: l data size equals: 2.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy addOrRemoveNext.
	self assert: l selectionStrategy currentIndex equals: 1.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 1 ).
	l selectionStrategy addOrRemoveNext.
	self assert: l selectionStrategy currentIndex equals: 2.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 1 2 ).
	l selectionStrategy addOrRemovePrevious.
	self assert: l selectionStrategy currentIndex equals: 1.
	self
		assert: l selectionStrategy selectedIndexes asArray
		equals: #( 1 )
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithTwoElementSelectNextInSelection [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 2).
	self assert: l data size equals: 2.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectNext.
	self assert: l selectionStrategy currentIndex equals: 1.
	self assert: l selectionStrategy selectedIndex equals: 1.
	l selectionStrategy selectNext.
	self assert: l selectionStrategy currentIndex equals: 2.
	self assert: l selectionStrategy selectedIndex equals: 2.
	l selectionStrategy selectNext.
	self assert: l selectionStrategy currentIndex equals: 1.
	self assert: l selectionStrategy selectedIndex equals: 1
]

{ #category : #'test selection - select next/previous' }
ToInfiniteElementTest >> testListWithTwoElementSelectPreviousInSelection [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 2).
	self assert: l data size equals: 2.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectPrevious.
	self assert: l selectionStrategy currentIndex equals: 2.
	self assert: l selectionStrategy selectedIndex equals: 2.
	l selectionStrategy selectPrevious.
	self assert: l selectionStrategy currentIndex equals: 1.
	self assert: l selectionStrategy selectedIndex equals: 1.
	l selectionStrategy selectPrevious.
	self assert: l selectionStrategy currentIndex equals: 2.
	self assert: l selectionStrategy selectedIndex equals: 2
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testRemoveAll [

	| l |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l children size equals: 5.
	l selectionStrategy selectOnlyIndex: 2.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes equals: #( 2 ).
	l data removeAll.
	l forceLayout.
	self assert: l children size equals: 0.
	l selectionStrategy shiftAfterRemovingAt: 2 itemCount: 3.
	self assert: l selectionStrategy selectedIndexes isEmpty
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterInsert [

	| l sp |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectOnlyIndex: 3.
	self assert: l selectionStrategy currentIndex equals: 3.
	l data add: (self statesOfAmerica at: 6) afterIndex: 1.
	self assert: l selectionStrategy currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	l selectionStrategy shiftAfterAddingAt: 1 itemCount: 1.
	self assert: l selectionStrategy currentIndex equals: 4.
	self assert: l selectionStrategy selectedIndex equals: 4
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterInsert1 [

	| l sp |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectOnlyIndex: 3.
	self assert: l selectionStrategy selectedIndexes equals: { 3 }.
	self assert: l selectionStrategy currentIndex equals: 3.
	self assert: l children size equals: 5.
	l data addAllFirst: (self statesOfAmerica copyFrom: 6 to: 10).
	self assert: l data size equals: 10.
	self assert: l children size equals: 5.
	self assert: l selectionStrategy currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	self assert: l selectionStrategy currentIndex equals: 3.
	l selectionStrategy shiftAfterAddingAt: 3 itemCount: 5.
	self assert: l selectionStrategy selectedIndex equals: 8
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterInsert2 [

	| l sp |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectOnlyIndex: 3.
	self assert: l selectionStrategy currentIndex equals: 3.
	l data add: (self statesOfAmerica at: 6) afterIndex: 3.
	self assert: l selectionStrategy currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	self assert: l selectionStrategy currentIndex equals: 3
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterInsert3 [

	| l sp |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectIndexes: #( 3 4 ).
	self assert: l selectionStrategy selectedIndexes equals: #( 3 4 ).
	self assert: l selectionStrategy currentIndex equals: 3.
	l data add: (self statesOfAmerica at: 6) afterIndex: 1.
	self assert: l selectionStrategy currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	l selectionStrategy shiftAfterAddingAt: 1 itemCount: 1.
	self assert: l selectionStrategy currentIndex equals: 4.
	self assert: l selectionStrategy selectedIndexes equals: #( 4 5 )
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterRemove [

	| l sp |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectOnlyIndex: 3.
	self assert: l selectionStrategy currentIndex equals: 3.
	l data removeAt: 2.
	self assert: l selectionStrategy currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	l selectionStrategy shiftAfterRemovingAt: 2 itemCount: 1.
	self assert: l selectionStrategy currentIndex equals: 2.
	self assert: l selectionStrategy selectedIndex equals: 2
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterRemove1 [

	| l sp |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectOnlyIndex: 3.
	self assert: l selectionStrategy currentIndex equals: 3.
	self assert: l children size equals: 5.
	l data removeAll.
	self assert: l selectionStrategy currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	self assert: l children size equals: 0.
	self assert: l data size equals: 0.
	l selectionStrategy shiftAfterRemovingAt: 1 itemCount: 5.
	self assert: l selectionStrategy currentIndex equals: 0.
	self assert: l selectionStrategy selectedIndex equals: 0
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterRemove2 [

	| l sp |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectOnlyIndex: 3.
	self assert: l selectionStrategy currentIndex equals: 3.
	l data removeAt: 4.
	self assert: l selectionStrategy currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	self assert: l selectionStrategy currentIndex equals: 3
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterRemove3 [

	| l sp |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectIndexes: #( 3 4 ).
	self assert: l selectionStrategy selectedIndexes equals: #( 3 4 ).
	self assert: l selectionStrategy currentIndex equals: 3.
	l data removeAt: 2.
	self assert: l selectionStrategy currentIndex equals: 3.
	sp := l inSpace.
	sp pulse.
	l selectionStrategy shiftAfterRemovingAt: 2 itemCount: 1.
	self assert: l selectionStrategy currentIndex equals: 2.
	self assert: l selectionStrategy selectedIndexes equals: #( 2 3 )
]

{ #category : #'test selection - adding/removing' }
ToInfiniteElementTest >> testSelectionUpdatedAfterRemove4 [

	| l sp |
	l := ToInfiniteElement new.
	l selectionStrategy: ToStandardListSelectionStrategy new.

	l fitContent.
	l data addAll: (self statesOfAmerica copyFrom: 1 to: 5).
	self assert: l data size equals: 5.
	l forceLayout.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	l selectionStrategy selectOnlyIndex: 2.
	self assert: l selectionStrategy currentIndex equals: 2.
	self assert: l selectionStrategy pivot isNil.
	self assert: l selectionStrategy distance isNil.
	l data removeAt: 2.
	self assert: l selectionStrategy currentIndex equals: 2.
	sp := l inSpace.
	sp pulse.
	l selectionStrategy shiftAfterRemovingAt: 2 itemCount: 1.
	self assert: l selectionStrategy selectedIndexes isEmpty.
	self assert: l selectionStrategy currentIndex equals: 0
]
