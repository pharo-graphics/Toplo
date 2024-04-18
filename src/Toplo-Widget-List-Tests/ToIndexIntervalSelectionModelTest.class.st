Class {
	#name : #ToIndexIntervalSelectionModelTest,
	#superclass : #TestCase,
	#instVars : [
		's'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Model'
}

{ #category : #accessing }
ToIndexIntervalSelectionModelTest >> itemCount [

	^ 1000
]

{ #category : #running }
ToIndexIntervalSelectionModelTest >> setUp [

	super setUp.
	s := ToIndexIntervalSelectionModel new.

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testContainsIndex [

	self deny: (s containsIndex: 1)
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testCopyCompositeModel [

	| c |
	c := s copy.
	self deny: s intervals identicalTo: c intervals.
	self assert: c equals: s
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testDeselectAndDeselectedIndex [

	s removeAll.
	s selectIndexes: #(1 5 8 12 16).
	self assert: s indices equals: #(1 5 8 12 16).
	s deselectIndex: 4.
	self assert: s indices equals: #(1 5 8 12 16)
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testDeselectAndDeselectedIndex2 [

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
ToIndexIntervalSelectionModelTest >> testDeselectAndDeselectedIndex3 [

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
ToIndexIntervalSelectionModelTest >> testDeselectIndex [

	s removeAll.
	s selectIndexes: { 1 }.
	self assert: s indices equals: { 1. }.
	s deselectIndex: 1.
	self assert: s indices equals: {  }.

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testDeselectIndex10 [

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
ToIndexIntervalSelectionModelTest >> testDeselectIndex2 [

	s removeAll.
	s selectIndexes: { 1 }.
	s deselectIndex: 2.
	self assert: s indices equals: { 1 }.

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testDeselectIndex3 [

	s removeAll.
	s selectIndexes: { 1. 2. 5. 10}.
	s deselectIndex: 8.
	self assert: s indices equals: { 1. 2. 5. 10 }.

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testDeselectIndexes [

	s selectIndexes: { 1. 5. 6 }.
	self assert: s indices  equals: { 1. 5. 6 } .
	s deselectIndexes: { 10. 50. 60 }.
	self assert: s indices  equals: { 1. 5. 6 } .
	s deselectIndexes: { 5. 6 }.
	self assert: s indices  equals: { 1.  } 
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testDeselectTo [

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
ToIndexIntervalSelectionModelTest >> testEquals [

	self assert: s equals: ToIndexIntervalSelectionModel new

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testFirstIndex [

	s removeAll.
	self assert: s firstIndex equals: 0.
	s selectIndexes: #( 4 6 8).
	self assert: s firstIndex equals: 4	
	
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testIndices [

	s selectIndexes: { 1. 5. 6 }.
	self assert: s indices equals: { 1. 5. 6 }.
	s selectIndexes: { 10. 50. 60 }.
	self assert: s indices equals: { 1. 5. 6. 10. 50. 60 }
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testIndicesCollect [

	| collected |
	s removeAll.
	collected := s indicesCollect: [ :idx | idx ].
	self assert: collected equals: #(  ).
	s selectIndexes: #( 4 6 8 ).
	collected := s indicesCollect: [ :idx | idx ].
	self assert: collected equals: #( 4 6 8 )
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testIndicesCount [

	s removeAll.
	self assert: s indicesCount equals: 0.
	s selectIndexes: #( 4 6 8 ).
	self assert: s indicesCount equals: 3
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testIndicesDo [

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
ToIndexIntervalSelectionModelTest >> testInitialize [ 

	self assert: s isEmpty.
	self assert: (s intervals isKindOf: OrderedCollection  ).
]

{ #category : #test }
ToIndexIntervalSelectionModelTest >> testInsertInterval [

	s removeAll.
	self assert: s intervals asArray equals: {  }.
	s insertInterval: (1 to: 2).
	self assert: s intervals asArray equals: { (1 to: 2) }.
	s insertInterval: (3 to: 4).
	self assert: s intervals asArray equals: { (1 to: 4) }.
	s insertInterval: (6 to: 7).
	self assert: s intervals asArray equals: { (1 to: 4). (6 to: 7) }.
	s insertInterval: (1 to: 7).
	self assert: s intervals asArray equals: { (1 to: 7) }.
	s insertInterval: (0 to: 6).
	self assert: s intervals asArray equals: { (0 to: 7) }.
	s insertInterval: (12 to: 12).
	self assert: s intervals asArray equals: { (0 to: 7). (12 to: 12). }.
	s insertInterval: (8 to: 13).
	self assert: s intervals asArray equals: { (0 to: 13).  }.

	


	" 
    
     def test_insertOverlappingBothSidesOfExisting(self):
        self.assertEqual(myInsertInterval([[6, 7]], [1, 9]), [[1, 9]] , ""Expected [[1, 9]]"")
    def test_insertWithinExistingInterval(self):
        self.assertEqual(myInsertInterval([[1, 9]], [6, 7]), [[1, 9]] , ""Expected [[1, 9]]"")
    def test_insertAndMergeBeginningExact(self):
        self.assertEqual(myInsertInterval([[6, 7]], [1, 6]), [[1, 7]], ""Expected [[1, 7]]"")
    def test_insertAndMerge2Intervals(self):
        self.assertEqual(myInsertInterval([[1, 5], [10, 15], [20, 25]], [12, 22]), [[1, 5], [10, 25]], ""Expected [[1, 5], [10, 25]]"")
    def test_insertAndMerge3Intervals(self):
        self.assertEqual(myInsertInterval([[1, 2], [10, 11], [20, 21]], [2, 30]), [[1, 30]], ""Expected [[1,30]]"")
    def test_insertExisting(self):
        self.assertEqual(myInsertInterval([[1, 2], [3, 4]], [1, 2]), [[1, 2], [3, 4]], ""Expected [[1, 2], [3, 4]]"")"
]

{ #category : #test }
ToIndexIntervalSelectionModelTest >> testInsertInterval2 [

	s removeAll.
	s insertInterval: (4 to: 6).
	s insertInterval: (11 to: 13).
	self assert: s intervals asArray equals: { (4 to: 6). (11 to: 13) }.
	s insertInterval: (7 to: 10).
	self assert: s intervals asArray equals: { (4 to: 13) }.
]

{ #category : #test }
ToIndexIntervalSelectionModelTest >> testInsertInterval3 [

	s removeAll.
	s insertInterval: (1 to: 4).
	s insertInterval: (6 to: 7).
	self assert: s intervals asArray equals: { (1 to: 4). (6 to: 7) }
]

{ #category : #test }
ToIndexIntervalSelectionModelTest >> testInsertInterval4 [

	s removeAll.
	s insertInterval: (1 to: 2).
	s insertInterval: (3 to: 4).
	self assert: s intervals asArray equals: { (1 to: 4) }

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testIntervalContainingIndex [

	s removeAll.
	s addInterval: (1 to: 3).
	self assert: (s positionOfIntervalContainingIndex: 0) equals: 0.
	self assert: (s positionOfIntervalContainingIndex: 1) equals: 1.
	self assert: (s positionOfIntervalContainingIndex: 2) equals: 1.
	self assert: (s positionOfIntervalContainingIndex: 3) equals: 1.
	self assert: (s positionOfIntervalContainingIndex: 4) equals: 0.

	s addInterval: (5 to: 5).
	self assert: (s positionOfIntervalContainingIndex: 5) equals: 2.
	s addInterval: (1 to: 6).
	self assert: (s positionOfIntervalContainingIndex: 0) equals: 0.
	self assert: (s positionOfIntervalContainingIndex: 1) equals: 1.
	self assert: (s positionOfIntervalContainingIndex: 2) equals: 1.
	self assert: (s positionOfIntervalContainingIndex: 3) equals: 1.
	self assert: (s positionOfIntervalContainingIndex: 4) equals: 1.
	self assert: (s positionOfIntervalContainingIndex: 5) equals: 1.
	self assert: (s positionOfIntervalContainingIndex: 6) equals: 1.
	self assert: (s positionOfIntervalContainingIndex: 7) equals: 0.




]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testIntervals [

	self assert: (s intervals isKindOf: OrderedCollection )
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testIsEmpty [

	self assert: s isEmpty

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testLastIndex [

	self assert: s lastIndex equals: 0.
	s selectIndexes: #( 4 6 8 ).
	self assert: s lastIndex equals: 8.

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testRemoveAll [

	s removeAll.
	self assert: s isEmpty .
	s selectIndex: 10.
	s removeAll.
	self assert: s isEmpty

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testSelectIndex [

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
ToIndexIntervalSelectionModelTest >> testSelectIndexes [

	s removeAll.
	s selectIndexes: { 1. 5. 6 }.
	self assert: s indices equals: { 1. 5. 6 }.
	s selectIndexes: { 10. 50. 60 }.
	self assert: s indices equals: { 1. 5. 6. 10. 50. 60 }
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testSelectTo [

	s select: 5 to: 9.
	self assert: s indices equals: { 5. 6. 7. 8. 9 }.
	s 	select: 10 to: 15.
	self assert: s indices equals: { 5. 6. 7. 8. 9. 10. 11. 12. 13. 14. 15 }
]
