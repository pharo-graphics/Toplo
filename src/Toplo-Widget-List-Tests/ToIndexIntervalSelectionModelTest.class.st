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

	| s c |
	s := ToSelectionModel new.
	c := s copy.
	self deny: s underlyingModel identicalTo: c underlyingModel.
	self assert: c equals: s
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testCopySelectionFrom [

	| s s2 |
	s := ToSelectionModel new itemCountGetter: 100.
	s2 := s copy.
	s selectIndexes: { 1. 5. 6 }.
	s2 copySelectionFrom: s.
	self assert: s equals: s2.
	self deny: s underlyingModel identicalTo: s2 underlyingModel.
	s deselectIndexes: { 10. 50. 60 }.
	s2 copySelectionFrom: s.
	self assert: s equals: s2.
	s deselectIndexes: { 5. 6 }.
	s2 copySelectionFrom: s.
	self assert: s equals: s2.

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testDeselectAll [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s deselectAll.
	self assert: s isEmpty .
	s selectIndex: 10.
	s deselectAll.
	self assert: s isEmpty

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testDeselectAllIndexesWithAWholeSelection [

	| s |
	s := ToSelectionModel new itemCountGetter: 10.
	s selectAll.
	" item count that is necessary in that case "
	s deselectIndexes: { 2. 4. 6 }.
	self assert: s selectedIndexes equals: { 1. 3. 5. 7. 8. 9. 10 }
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testDeselectAllIndexesWithAWholeSelection2 [

	| s |
	s := ToSelectionModel new.
	" no way to get item count that is necessary in that case -> Error"
	self should: [s selectAll] raise: Error.
	s deselectIndexes: { 2. 4. 6 }.
	self assert: s isEmpty

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testDeselectAndDeselectedIndex [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s deselectAll.
	s selectIndexes: #(1 5 8 12 16).
	self assert: s selectedIndexes equals: #(1 5 8 12 16).
	s deselectIndex: 4.
	self assert: s selectedIndexes equals: #(1 5 8 12 16)
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testDeselectAndDeselectedIndex2 [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s deselectAll.
	s selectIndex: 1.
	s selectIndex: 5.
	s selectIndex: 8.
	s selectIndex: 12.
	s selectIndex: 16.
	self assert: s selectedIndexes equals: #(1 5 8 12 16).
	s deselectIndex: 4.
	self assert: s selectedIndexes equals: #(1 5 8 12 16)
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testDeselectAndDeselectedIndex3 [

	| s |
	self skip.
	self flag: 'Reported as a BlCompositeSelection issue (see issue #489 and BlCompositeSelectionTest)'.
	s := ToSelectionModel new itemCountGetter: 100.
	s deselectAll.
	s selectIndex: 1.
	s selectIndex: 5.
	s selectIndex: 8.
	s selectIndex: 12.
	s selectIndex: 16.
	self assert: s selectedIndexes equals: #(1 5 8 12 16).
	s selectIndex: 1.
	s deselectIndex: 4.
	self assert: s selectedIndexes equals: #(1 5 8 12 16)
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testDeselectIndex [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectIndexes: { 1. 5. 6 }.
	self assert: s selectedIndexes asSet equals: { 1. 5. 6 } asSet.
	s deselectIndex: 10.
	self assert: s selectedIndexes asSet equals: { 1. 5. 6 } asSet.
	s deselectIndex: 5.
	s deselectIndex: 6.
	self assert: s selectedIndexes asSet equals: { 1.  } asSet
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testDeselectIndexTo [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectIndex: 5 to: 15.
	s 	deselectIndex: 8 to: 12.
	self assert: s selectedIndexes equals: { 5. 6. 7. 13. 14. 15 }.
	s deselectAll.
	s selectIndex: 5 to: 15.
	s 	deselectIndex: 12 to: 8.
	self assert: s selectedIndexes equals: { 5. 6. 7. 13. 14. 15 }
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testDeselectIndexes [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectIndexes: { 1. 5. 6 }.
	self assert: s selectedIndexes asSet equals: { 1. 5. 6 } asSet.
	s deselectIndexes: { 10. 50. 60 }.
	self assert: s selectedIndexes asSet equals: { 1. 5. 6 } asSet.
	s deselectIndexes: { 5. 6 }.
	self assert: s selectedIndexes asSet equals: { 1.  } asSet
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testEquals [

	| s |
	s := ToSelectionModel new.
	self assert: s equals: ToSelectionModel new.

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testFirstIndex [

	| s |
	s := ToSelectionModel new.
	self assert: s firstIndex equals: 0.
	s itemCountGetter: [ 100 ].
	self assert: s firstIndex equals: 0.
	s selectIndexes: #( 4 6 8).
	self assert: s firstIndex equals: 4.
	s selectAll.
	self assert: s firstIndex equals: 1.

	
	
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testInitialize [ 

	| s |
	s := ToSelectionModel new.
	self assert: s isEmpty.
	self assert: (s underlyingModel isKindOf: BlCompositeSelection ).
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
	s insertInterval: (1 to: 3).
	self assert: (s positionOfIntervalContainingIndex: 0) equals: 0.
	self assert: (s positionOfIntervalContainingIndex: 1) equals: 1.
	self assert: (s positionOfIntervalContainingIndex: 2) equals: 1.
	self assert: (s positionOfIntervalContainingIndex: 3) equals: 1.
	self assert: (s positionOfIntervalContainingIndex: 4) equals: 0.

	s insertInterval: (5 to: 5).
	self assert: (s positionOfIntervalContainingIndex: 5) equals: 2.
	s insertInterval: (1 to: 6).
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
ToIndexIntervalSelectionModelTest >> testIsEmpty [

	| s |
	s := ToSelectionModel new.
	self assert: s isEmpty

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testItemCount [

	| s |
	s := ToSelectionModel new onInstalledIn: self.
	self assert: s itemCount equals: self itemCount.
	s underlyingModel selectIndex: 1.
	s assert: (s containsIndex: 1)
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testItemCountGetter [

	| s |
	s := ToSelectionModel new onInstalledIn: self.
	self assert: s itemCount equals: s itemCountGetter value.
	s itemCountGetter: [ 1000 ].
	self assert: s itemCount equals: 1000.
	

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testLastIndex [

	| s |
	s := ToSelectionModel new.
	self assert: s lastIndex equals: 0.
	s itemCountGetter: [ 100 ].
	self assert: s lastIndex equals: 0.
	s selectIndexes: #( 4 6 8 ).
	self assert: s lastIndex equals: 8.
	s selectAll.
	self assert: s lastIndex equals: 100
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testOnInstalledIn [

	| s |
	s := ToSelectionModel new.
	s onInstalledIn: self.
	self assert: s itemCountGetter notNil.
	self assert: s itemCountGetter value equals: self itemCount 
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testOnUninstalledIn [

	| s |
	s := ToSelectionModel new.
	s onInstalledIn: self.
	s onUninstalledIn: self.
	self should: [ s itemCountGetter ] raise: Error.
	self should: [ s itemCount ] raise: Error
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testSelectAll [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectAll.
	self assert: s lastIndex equals: 100.
	s selectIndex: 10.
	s selectAll.
	self assert: s lastIndex equals: 100.

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testSelectAllThenDeselectOneByOne [

	| s |
	self skip.
	self flag: 'Reported as a BlCompositeSelection issue (see issue #489 and BlCompositeSelectionTest)'.
	s := ToSelectionModel new itemCountGetter: 48.
	s selectIndexes: (1 to: 48).
	s deselectIndex: 26.
	self assert: s deselectedIndexes equals: #(26).
	s deselectIndex: 28.
	self assert: s deselectedIndexes equals: #(26 28).
	s deselectIndex: 35.
	self assert: s deselectedIndexes equals: #(26 28 35).
	s deselectIndex: 18.
	self assert: s deselectedIndexes equals: #(18 26 28 35).
	s deselectIndex: 40.
	self assert: s deselectedIndexes equals: #(18 26 28 35 40).
	s deselectIndex: 31.
	self assert: s deselectedIndexes equals: #(18 26 28 31 35 40).
	s deselectIndex: 19.
	self assert: s deselectedIndexes equals: #(18 19 26 28 31 35 40).
	s deselectIndex: 17.
	self assert: s deselectedIndexes equals: #(17 18 19 26 28 31 35 40).
	s deselectIndex: 45.
	self assert: s deselectedIndexes equals: #(17 18 19 26 28 31 35 40 45).
	s deselectIndex: 48.
	self assert: s deselectedIndexes equals: #(17 18 19 26 28 31 35 40 45 48).
	s deselectIndex: 36.
	self assert: s deselectedIndexes equals: #(17 18 19 26 28 31 35 36 40 45 48)
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testSelectIndex [

	s selectIndex: 1.
	s assert: (s containsIndex: 1).
	s selectIndex: 5.
	s selectIndex: 6.
	self assert: s selectedIndexes equals: { 1. 5. 6 }.
	s selectIndex: 10.
	s selectIndex: 50.
	s selectIndex: 60.
	self assert: s selectedIndexes equals: { 1. 5. 6. 10. 50. 60 }
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testSelectIndexTo [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectIndex: 5 to: 9.
	self assert: s selectedIndexes equals: { 5. 6. 7. 8. 9 }.
	s 	selectIndex: 15 to: 10.
	self assert: s selectedIndexes equals: { 5. 6. 7. 8. 9. 10. 11. 12. 13. 14. 15 }
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testSelectIndexes [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectIndexes: { 1. 5. 6 }.
	self assert: s selectedIndexes equals: { 1. 5. 6 }.
	s selectIndexes: { 10. 50. 60 }.
	self assert: s selectedIndexes equals: { 1. 5. 6. 10. 50. 60 }
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testSelectedIndexesCollect [

	| s collected |
	s := ToSelectionModel new.
	s itemCountGetter: [ 100 ].
	collected := s selectedIndexesCollect: [ :idx | idx ].
	self assert: collected equals: #(  ).
	s selectIndexes: #( 4 6 8 ).
	collected := s selectedIndexesCollect: [ :idx | idx ].
	self assert: collected equals: #( 4 6 8 ).
	s deselectAll.
	collected := s selectedIndexesCollect: [ :idx | idx ].
	self assert: collected equals: #(  ).
	s selectAll.
	collected := s selectedIndexesCollect: [ :idx | idx ].
	self assert: collected equals: (( 1 to: 100 ) collect: [:idx | idx]).

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testSelectedIndexesCount [

	| s |
	s := ToSelectionModel new.
	s itemCountGetter: [ 100 ].
	self assert: s selectedIndexesCount equals: 0.
	s selectIndexes: #( 4 6 8 ).
	self assert: s selectedIndexesCount equals: 3.
	s deselectAll.
	self assert: s selectedIndexesCount equals: 0.
	s selectAll.
	self assert: s selectedIndexesCount equals: 100
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testSelectedIndexesDo [

	| s count |
	s := ToSelectionModel new.
	s itemCountGetter: [ 100 ].
	count := 0.
	s selectedIndexesDo: [ :idx | count := count + 1 ].
	self assert: count equals: 0.
	s selectIndexes: #( 4 6 8 ).
	count := 0.
	s selectedIndexesDo: [ :idx | count := count + 1 ].
	self assert: count equals: 3.
	s deselectAll.
	count := 0.
	s selectedIndexesDo: [ :idx | count := count + 1 ].
	self assert: count equals: 0.
	s selectAll.
	count := 0.
	s selectedIndexesDo: [ :idx | count := count + 1 ].
	self assert: count equals: 100.

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testSelectedItemCount [

	| s |
	s := ToSelectionModel new onInstalledIn: self.
	self assert: s selectedIndexesCount equals: 0.
	s selectIndex: 1.
	self assert: s selectedIndexesCount equals: 1.
	s selectAll.
	self assert: s selectedIndexesCount equals: self itemCount.
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testShiftFrom [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectIndexes: { 1. 5. 6 }.
	self assert: s selectedIndexes  equals: { 1. 5. 6 }.
	s shift: 1 from: 1.
	self assert: s selectedIndexes  equals: { 2. 6. 7 } .
	s shift: -1 from: 1.
	self assert: s selectedIndexes  equals: { 1. 5. 6 }.

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testShiftFrom10 [

	| s |
	s := ToSelectionModel new itemCountGetter: 200.
	s selectIndexes: { 4. 5. 7. 8. 10. 11 }.
	{ 4. 5. 7. 8. 10. 11 } do: [ :idx | s shift: -1 from: idx ].
	self assert: s selectedIndexes  equals: { 3. 4. 5. 6. 7 }
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testShiftFrom2 [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectIndexes: { 1. 5. 6 }.
	self assert: s selectedIndexes  equals: { 1. 5. 6 }.
	s shift: 3 from: 5.
	self assert: s selectedIndexes  equals: { 1. 8. 9 } .
	s shift: -3 from: 1.
	self assert: s selectedIndexes  equals: { 5. 6 }.
	s shift: -3 from: 1.
	self assert: s selectedIndexes  equals: { 2. 3 }


]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testShiftFrom3 [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectIndexes: { 2. 3 }.
	s shift: -2 from: 3.
	self assert: s selectedIndexes  equals: { 1 }.
	s shift: -1 from: 1.
	self assert: s selectedIndexes  equals: {  }.





]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testShiftFrom4 [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectIndexes: { 1. 5. 6 }.
	self assert: s selectedIndexes  equals: { 1. 5. 6 }.
	s shift: 1 from: 1.
	self assert: s selectedIndexes  equals: { 2. 6. 7 } .

]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testShiftFrom5 [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectIndexes: { 2. 6. 7 }.
	s shift: 1 from: 6.
	self assert: s selectedIndexes  equals: { 2. 7. 8 }
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testShiftFrom6 [

	| s |
	s := ToSelectionModel new itemCountGetter: 2.
	s selectIndexes: { 1 }.
	s shift: -1 from: 2.
	self assert: s selectedIndexes  equals: { 1 }
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testShiftFrom7 [

	| s |
	s := ToSelectionModel new itemCountGetter: 200.
	s selectIndexes: { 3 }.
	s shift: -1 from: 4.
	self assert: s selectedIndexes  equals: { 3 }
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testShiftFrom8 [

	| s |
	s := ToSelectionModel new itemCountGetter: 200.
	s selectIndexes: { 3 }.
	s shift: 1 from: 1.
	self assert: s selectedIndexes  equals: { 4 }
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testShiftFrom9 [

	| s |
	s := ToSelectionModel new itemCountGetter: 200.
	s selectIndexes: { 4. 5. 7. 8. 10. 11 }.
	s shift: -1 from: 4.
	self assert: s selectedIndexes  equals: { 3. 4. 6. 7. 9. 10 }.
	s shift: -1 from: 5.
	self assert: s selectedIndexes  equals: { 3. 4. 5. 6. 8. 9 }.
	s shift: -1 from: 7.
	self assert: s selectedIndexes  equals: { 3. 4. 5. 6. 7. 8 }.
	s shift: -1 from: 8.
	self assert: s selectedIndexes  equals: { 3. 4. 5. 6. 7 }.
	s shift: -1 from: 10.
	self assert: s selectedIndexes  equals: { 3. 4. 5. 6. 7 }.
	s shift: -1 from: 11.
	self assert: s selectedIndexes  equals: { 3. 4. 5. 6. 7 }.
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testShiftFrom9bis [

	| s |
	s := ToSelectionModel new itemCountGetter: 200.
	s selectIndexes: { 3. 4. 5. 6. 7. 8 }.
	s shift: -1 from: 8.
	self assert: s selectedIndexes  equals: { 3. 4. 5. 6. 7 }.
	s shift: -1 from: 10.
	self assert: s selectedIndexes  equals: { 3. 4. 5. 6. 7 }.
	s shift: -1 from: 11.
	self assert: s selectedIndexes  equals: { 3. 4. 5. 6. 7 }
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testShiftFrom9bis2 [

	| s |
	s := ToSelectionModel new itemCountGetter: 200.
	s selectIndexes: { 4. 5. 7}.
	s shift: -1 from: 4.
	self assert: s selectedIndexes  equals: { 3. 4. 6}.
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testUnderlyingModel [

	| s |
	s := ToSelectionModel new.
	self assert: (s underlyingModel isKindOf: BlCompositeSelection)
]

{ #category : #tests }
ToIndexIntervalSelectionModelTest >> testselectedIndexes [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	self assert: s selectedIndexes equals: #(  ).
	s selectAll.
	self assert: s selectedIndexes equals: (1 to: 100)
]
