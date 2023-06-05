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
ToListInfiniteElementTest >> testEmptyListAddOrRemoveNext [

	| l |
	l := ToListInfiniteElement new.
	l fitContent.
	self assert: l data isEmpty.
	l forceLayout.
	self assert: l selectedIndexes isEmpty.
	l primarySelection selectPrevious.
	self assert: l primarySelection currentIndex isZero.
	self assert: l primarySelection isTowardNext
]

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testEmptyListSelectNext [

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
ToListInfiniteElementTest >> testEmptyListSelectPrevious [

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

{ #category : #'test - select next/previous' }
ToListInfiniteElementTest >> testListWithOneElementSelectNext [

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
ToListInfiniteElementTest >> testListWithOneElementSelectPrevious [

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
ToListInfiniteElementTest >> testListWithTwoElementSelectNext [

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
ToListInfiniteElementTest >> testListWithTwoElementSelectPrevious [

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
