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
	self assert: l size equals: (l padding left + l padding right) @ (l padding top + l padding bottom)
]

{ #category : #tests }
ToListInfiniteElementTest >> testInfiniteWithOneElement [

	| l |
	l := ToListInfiniteElement new.
	self assert: l data isEmpty
]
