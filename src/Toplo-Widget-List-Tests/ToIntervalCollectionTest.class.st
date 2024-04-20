Class {
	#name : #ToIntervalCollectionTest,
	#superclass : #TestCase,
	#instVars : [
		's'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Model'
}

{ #category : #accessing }
ToIntervalCollectionTest >> itemCount [

	^ 1000
]

{ #category : #running }
ToIntervalCollectionTest >> setUp [

	super setUp.
	s := ToIntervalCollection new.

]

{ #category : #tests }
ToIntervalCollectionTest >> testContainsIndex [

	self deny: (s containsIndex: 1)
]

{ #category : #tests }
ToIntervalCollectionTest >> testCopyCompositeModel [

	| c |
	c := s copy.
	self deny: s intervals identicalTo: c intervals.
	self assert: c equals: s
]

{ #category : #tests }
ToIntervalCollectionTest >> testDeselectAndDeselectedIndex [

	s removeAll.
	s selectIndexes: #(1 5 8 12 16).
	self assert: s indices equals: #(1 5 8 12 16).
	s deselectIndex: 4.
	self assert: s indices equals: #(1 5 8 12 16)
]

{ #category : #tests }
ToIntervalCollectionTest >> testDeselectAndDeselectedIndex2 [

	s removeAll.
	s selectIndex: 1.
	s selectIndex: 5.
	s selectIndex: 8.
	s selectIndex: 12.
	s selectIndex: 16.
	self assert: s indices equals: #(1 5 8 12 16).
	s deselectIndex: 4.
	self assert: s indices equals: #(1 5 8 12 16)
]

{ #category : #tests }
ToIntervalCollectionTest >> testDeselectAndDeselectedIndex3 [

	s removeAll.
	s selectIndex: 1.
	s selectIndex: 5.
	s selectIndex: 8.
	s selectIndex: 12.
	s selectIndex: 16.
	self assert: s indices equals: #(1 5 8 12 16).
	s selectIndex: 1.
	s deselectIndex: 4.
	self assert: s indices equals: #(1 5 8 12 16)
]

{ #category : #tests }
ToIntervalCollectionTest >> testDeselectIndex [

	s removeAll.
	s selectIndexes: { 1 }.
	self assert: s indices equals: { 1. }.
	s deselectIndex: 1.
	self assert: s indices equals: {  }.

]

{ #category : #tests }
ToIntervalCollectionTest >> testDeselectIndex10 [

	s removeAll.
	s selectIndexes: { 1. 5. 6 }.
	self assert: s indices equals: { 1. 5. 6 }.
	s deselectIndex: 10.
	self assert: s indices equals: { 1. 5. 6 }.
	s deselectIndex: 5.
	s deselectIndex: 6.
	self assert: s indices equals: { 1 }
]

{ #category : #tests }
ToIntervalCollectionTest >> testDeselectIndex2 [

	s removeAll.
	s selectIndexes: { 1 }.
	s deselectIndex: 2.
	self assert: s indices equals: { 1 }.

]

{ #category : #tests }
ToIntervalCollectionTest >> testDeselectIndex3 [

	s removeAll.
	s selectIndexes: { 1. 2. 5. 10}.
	s deselectIndex: 8.
	self assert: s indices equals: { 1. 2. 5. 10 }.

]

{ #category : #tests }
ToIntervalCollectionTest >> testDeselectIndexes [

	s selectIndexes: { 1. 5. 6 }.
	self assert: s indices equals: { 1. 5. 6 }.
	s deselectIndexes: { 10. 50. 60 }.
	self assert: s indices equals: { 1. 5. 6 }.
	s deselectIndexes: { 5. 6 }.
	self assert: s indices equals: { 1 }
]

{ #category : #tests }
ToIntervalCollectionTest >> testDeselectTo [

	s removeAll.
	s select: 5 to: 15.
	s 	deselect: 8 to: 12.
	self assert: s indices equals: { 5. 6. 7. 13. 14. 15 }.
	s removeAll.
	s select: 5 to: 15.
	s 	deselect: 8 to: 12.
	self assert: s indices equals: { 5. 6. 7. 13. 14. 15 }
]

{ #category : #tests }
ToIntervalCollectionTest >> testEquals [

	self assert: s equals: ToIntervalCollection new

]

{ #category : #tests }
ToIntervalCollectionTest >> testEquals1 [

	| s2 |
	s select: 9 to: 20.
	s2 := ToIntervalCollection new.
	s2 select: 9 to: 20.
	self assert: s equals: s2

]

{ #category : #tests }
ToIntervalCollectionTest >> testEquals2 [

	| sc |
	1 to: 10 by: 2 do: [ :idx | s selectIndex: idx ].
	self assert: s intervals size equals: 5.
	sc := s copy.
	1 to: 10 by: 1 do: [ :idx | s selectIndex: idx ].
	self assert: s intervals size equals: 1.
	2 to: 99 by: 2 do: [ :idx | s deselectIndex: idx ].
	self assert: s intervals size equals: 5.
	self assert: s equals: sc
]

{ #category : #tests }
ToIntervalCollectionTest >> testFirstIndex [

	s removeAll.
	self assert: s firstIndex equals: 0.
	s selectIndexes: #( 4 6 8).
	self assert: s firstIndex equals: 4	
	
]

{ #category : #tests }
ToIntervalCollectionTest >> testIndices [

	s selectIndexes: { 1. 5. 6 }.
	self assert: s indices equals: { 1. 5. 6 }.
	s selectIndexes: { 10. 50. 60 }.
	self assert: s indices equals: { 1. 5. 6. 10. 50. 60 }
]

{ #category : #tests }
ToIntervalCollectionTest >> testIndicesCollect [

	| collected |
	s removeAll.
	collected := s indicesCollect: [ :idx | idx ].
	self assert: collected equals: #(  ).
	s selectIndexes: #( 4 6 8 ).
	collected := s indicesCollect: [ :idx | idx ].
	self assert: collected equals: #( 4 6 8 )
]

{ #category : #tests }
ToIntervalCollectionTest >> testIndicesCount [

	s removeAll.
	self assert: s indicesCount equals: 0.
	s selectIndexes: #( 4 6 8 ).
	self assert: s indicesCount equals: 3
]

{ #category : #tests }
ToIntervalCollectionTest >> testIndicesDo [

	| count |
	s removeAll.
	count := 0.
	s indicesDo: [ :idx | count := count + 1 ].
	self assert: count equals: 0.
	s selectIndexes: #( 4 6 8 ).
	count := 0.
	s indicesDo: [ :idx | count := count + 1 ].
	self assert: count equals: 3
]

{ #category : #tests }
ToIntervalCollectionTest >> testInitialize [ 

	self assert: s isEmpty.
	self assert: (s intervals isKindOf: OrderedCollection  ).
]

{ #category : #tests }
ToIntervalCollectionTest >> testInsertInterval [

	s removeAll.
	self assert: s intervals asArray equals: {  }.
	s addInterval: (1 to: 2).
	self assert: s intervals asArray equals: { (1 to: 2) }.
	s addInterval: (3 to: 4).
	self assert: s intervals asArray equals: { (1 to: 4) }.
	s addInterval: (6 to: 7).
	self assert: s intervals asArray equals: { (1 to: 4). (6 to: 7) }.
	s addInterval: (1 to: 7).
	self assert: s intervals asArray equals: { (1 to: 7) }.
	s addInterval: (0 to: 6).
	self assert: s intervals asArray equals: { (0 to: 7) }.
	s addInterval: (12 to: 12).
	self assert: s intervals asArray equals: { (0 to: 7). (12 to: 12). }.
	s addInterval: (8 to: 13).
	self assert: s intervals asArray equals: { (0 to: 13).  }
]

{ #category : #tests }
ToIntervalCollectionTest >> testInsertInterval0 [

	s removeAll.
	self assert: s intervals asArray equals: {  }.
	1 to: 5 do: [ :idx | s selectIndex: idx ].
	self assert: s intervals asArray equals: { (1 to: 5) }.
	1 to: 5 by: 2 do: [ :idx | s selectIndex: idx ].
	self assert: s intervals asArray equals: { (1 to: 5) }.
	s removeAll.
	1 to: 5 by: 2 do: [ :idx | s selectIndex: idx ].
	self assert: s intervals asArray equals: { (1 to: 1). (3 to: 3). (5 to: 5) }.
	s selectIndex: 1.
	self assert: s intervals asArray equals: { (1 to: 1). (3 to: 3). (5 to: 5) }.
	s selectIndex: 2.
	self assert: s intervals asArray equals: { (1 to: 3). (5 to: 5) }.
	s selectIndex: 3.
	self assert: s intervals asArray equals: { (1 to: 3). (5 to: 5) }.
	s selectIndex: 4.
	self assert: s intervals asArray equals: { (1 to: 5) }.
	s selectIndex: 5.
	self assert: s intervals asArray equals: { (1 to: 5) }
]

{ #category : #tests }
ToIntervalCollectionTest >> testInsertInterval1 [

	s removeAll.
	1 to: 20 by: 2 do: [ :idx | s selectIndex: idx ].
	self assert: s intervals asArray equals: {
			(1 to: 1).
			(3 to: 3).
			(5 to: 5).
			(7 to: 7).
			(9 to: 9).
			(11 to: 11).
			(13 to: 13).
			(15 to: 15).
			(17 to: 17).
			(19 to: 19) }.
	s select: 1 to: 20.
	self assert: s intervals asArray equals: { (1 to: 20) }
]

{ #category : #tests }
ToIntervalCollectionTest >> testInsertInterval10 [

	s removeAll.
	s addInterval: (1 to: 8).
	s addInterval: (4 to: 6).
	self assert: s intervals asArray equals: { (1 to: 8) }
]

{ #category : #tests }
ToIntervalCollectionTest >> testInsertInterval11 [

	s removeAll.
	s addInterval: (1 to: 2).
	s addInterval: (4 to: 6).
	s addInterval: (1 to: 2).
	self assert: s intervals asArray equals: { (1 to: 2). (4 to: 6) }

]

{ #category : #tests }
ToIntervalCollectionTest >> testInsertInterval12 [

	s removeAll.
	s addInterval: (2 to: 2).
	s addInterval: (4 to: 4).
	s addInterval: (8 to: 20).
	self assert: s intervals asArray equals: { (2 to: 2). (4 to: 4). (8 to: 20) }.
	s addInterval: (1 to: 15).
	self assert: s intervals asArray equals: { (1 to: 20) }.



]

{ #category : #tests }
ToIntervalCollectionTest >> testInsertInterval13 [

	s removeAll.
	s addInterval: (6 to: 6).
	s addInterval: (4 to: 4).
	s addInterval: (1 to: 1).
	self assert: s intervals asArray equals: { (1 to: 1). (4 to: 4). (6 to: 6) }

]

{ #category : #tests }
ToIntervalCollectionTest >> testInsertInterval2 [

	s removeAll.
	s addInterval: (4 to: 6).
	s addInterval: (11 to: 13).
	self assert: s intervals asArray equals: { (4 to: 6). (11 to: 13) }.
	s addInterval: (7 to: 10).
	self assert: s intervals asArray equals: { (4 to: 13) }.
]

{ #category : #tests }
ToIntervalCollectionTest >> testInsertInterval3 [

	s removeAll.
	s addInterval: (1 to: 4).
	s addInterval: (6 to: 7).
	self assert: s intervals asArray equals: { (1 to: 4). (6 to: 7) }
]

{ #category : #tests }
ToIntervalCollectionTest >> testInsertInterval4 [

	s removeAll.
	s addInterval: (1 to: 2).
	s addInterval: (3 to: 4).
	self assert: s intervals asArray equals: { (1 to: 4) }

]

{ #category : #tests }
ToIntervalCollectionTest >> testInsertInterval5 [

	s removeAll.
	s addInterval: (6 to: 7).
	s addInterval: (1 to: 9).
	self assert: s intervals asArray equals: { (1 to: 9) }

]

{ #category : #tests }
ToIntervalCollectionTest >> testInsertInterval6 [

	s removeAll.
	s addInterval: (6 to: 7).
	s addInterval: (1 to: 6).
	self assert: s intervals asArray equals: { (1 to: 7) }

]

{ #category : #tests }
ToIntervalCollectionTest >> testInsertInterval7 [

	s removeAll.
	s addInterval: (1 to: 5).
	s addInterval: (10 to: 15).
	s addInterval: (20 to: 25).
	s addInterval: (12 to: 22).
	self assert: s intervals asArray equals: {
			(1 to: 5).
			(10 to: 25) }
]

{ #category : #tests }
ToIntervalCollectionTest >> testInsertInterval8 [

	s removeAll.
	s addInterval: (1 to: 2).
	s addInterval: (10 to: 11).
	s addInterval: (20 to: 21).
	self assert: s intervals asArray equals: { (1 to: 2). (10 to: 11). (20 to: 21) }.
	s addInterval: (2 to: 30).
	self assert: s intervals asArray equals: { (1 to: 30) }
]

{ #category : #tests }
ToIntervalCollectionTest >> testInsertInterval9 [

	s removeAll.
	s addInterval: (1 to: 2).
	s addInterval: (10 to: 11).
	s addInterval: (20 to: 26).
	self assert: s intervals asArray equals: { (1 to: 2). (10 to: 11). (20 to: 26) }.
	s addInterval: (2 to: 18).
	self assert: s intervals asArray equals: { (1 to: 18). (20 to: 26) }
]

{ #category : #tests }
ToIntervalCollectionTest >> testIntervalContainingIndex [

	s removeAll.
	s addInterval: (1 to: 3).
	self assert: (s positionOfIntervalWithIndex: 0) equals: 0.
	self assert: (s positionOfIntervalWithIndex: 1) equals: 1.
	self assert: (s positionOfIntervalWithIndex: 2) equals: 1.
	self assert: (s positionOfIntervalWithIndex: 3) equals: 1.
	self assert: (s positionOfIntervalWithIndex: 4) equals: 0.

	s addInterval: (5 to: 5).
	self assert: (s positionOfIntervalWithIndex: 5) equals: 2.
	s addInterval: (1 to: 6).
	self assert: (s positionOfIntervalWithIndex: 0) equals: 0.
	self assert: (s positionOfIntervalWithIndex: 1) equals: 1.
	self assert: (s positionOfIntervalWithIndex: 2) equals: 1.
	self assert: (s positionOfIntervalWithIndex: 3) equals: 1.
	self assert: (s positionOfIntervalWithIndex: 4) equals: 1.
	self assert: (s positionOfIntervalWithIndex: 5) equals: 1.
	self assert: (s positionOfIntervalWithIndex: 6) equals: 1.
	self assert: (s positionOfIntervalWithIndex: 7) equals: 0.




]

{ #category : #tests }
ToIntervalCollectionTest >> testIntervals [

	self assert: (s intervals isKindOf: OrderedCollection )
]

{ #category : #tests }
ToIntervalCollectionTest >> testIsEmpty [

	self assert: s isEmpty

]

{ #category : #tests }
ToIntervalCollectionTest >> testLastIndex [

	self assert: s lastIndex equals: 0.
	s selectIndexes: #( 4 6 8 ).
	self assert: s lastIndex equals: 8.

]

{ #category : #tests }
ToIntervalCollectionTest >> testRemoveAll [

	s removeAll.
	self assert: s isEmpty .
	s selectIndex: 10.
	s removeAll.
	self assert: s isEmpty

]

{ #category : #tests }
ToIntervalCollectionTest >> testSelectIndex [

	s removeAll.
	s selectIndex: 1.
	s assert: (s containsIndex: 1).
	s selectIndex: 5.
	s selectIndex: 6.
	self assert: s indices equals: { 1. 5. 6 }.
	s selectIndex: 10.
	s selectIndex: 50.
	s selectIndex: 60.
	self assert: s indices equals: { 1. 5. 6. 10. 50. 60 }
]

{ #category : #tests }
ToIntervalCollectionTest >> testSelectIndexes [

	s removeAll.
	s selectIndexes: { 1. 5. 6 }.
	self assert: s indices equals: { 1. 5. 6 }.
	s selectIndexes: { 10. 50. 60 }.
	self assert: s indices equals: { 1. 5. 6. 10. 50. 60 }
]

{ #category : #tests }
ToIntervalCollectionTest >> testSelectTo [

	s select: 5 to: 9.
	self assert: s indices equals: { 5. 6. 7. 8. 9 }.
	s 	select: 10 to: 15.
	self assert: s indices equals: { 5. 6. 7. 8. 9. 10. 11. 12. 13. 14. 15 }
]
