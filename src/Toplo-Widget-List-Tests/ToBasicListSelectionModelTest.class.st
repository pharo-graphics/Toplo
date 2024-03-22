"
A ToSelectionModelTest is a test class for testing the behavior of ToSelectionModel
"
Class {
	#name : #ToBasicListSelectionModelTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-List-Tests-Selection-Model'
}

{ #category : #accessing }
ToBasicListSelectionModelTest >> itemCount [

	^ 1000
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testContainsIndex [

	| s |
	s := ToBasicListSelectionModel new.
	self deny: (s containsIndex: 1).
	s selectIndex: 1.
	s assert: (s containsIndex: 1).

]

{ #category : #tests }
ToBasicListSelectionModelTest >> testCopyCompositeModel [

	| s c |
	s := ToBasicListSelectionModel new.
	c := s copy.
	self deny: s underlyingModel identicalTo: c underlyingModel.
	self assert: c equals: s
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testCopySelectionFrom [

	| s s2 |
	s := ToBasicListSelectionModel new itemCountGetter: 100.
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
ToBasicListSelectionModelTest >> testDeselectAll [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 100.
	s deselectAll.
	self assert: s isEmpty .
	s selectIndex: 10.
	s deselectAll.
	self assert: s isEmpty

]

{ #category : #tests }
ToBasicListSelectionModelTest >> testDeselectAllIndexesWithAWholeSelection [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 10.
	s selectAll.
	" item count that is necessary in that case "
	s deselectIndexes: { 2. 4. 6 }.
	self assert: s selectedIndexes equals: { 1. 3. 5. 7. 8. 9. 10 }
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testDeselectAllIndexesWithAWholeSelection2 [

	| s |
	s := ToBasicListSelectionModel new.
	" no way to get item count that is necessary in that case -> Error"
	self should: [s selectAll] raise: Error.
	s deselectIndexes: { 2. 4. 6 }.
	self assert: s isEmpty

]

{ #category : #tests }
ToBasicListSelectionModelTest >> testDeselectIndex [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 100.
	s selectIndexes: { 1. 5. 6 }.
	self assert: s selectedIndexes asSet equals: { 1. 5. 6 } asSet.
	s deselectIndex: 10.
	self assert: s selectedIndexes asSet equals: { 1. 5. 6 } asSet.
	s deselectIndex: 5.
	s deselectIndex: 6.
	self assert: s selectedIndexes asSet equals: { 1.  } asSet
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testDeselectIndexTo [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 100.
	s selectIndex: 5 to: 15.
	s 	deselectIndex: 8 to: 12.
	self assert: s selectedIndexes equals: { 5. 6. 7. 13. 14. 15 }.
	s deselectAll.
	s selectIndex: 5 to: 15.
	s 	deselectIndex: 12 to: 8.
	self assert: s selectedIndexes equals: { 5. 6. 7. 13. 14. 15 }
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testDeselectIndexes [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 100.
	s selectIndexes: { 1. 5. 6 }.
	self assert: s selectedIndexes asSet equals: { 1. 5. 6 } asSet.
	s deselectIndexes: { 10. 50. 60 }.
	self assert: s selectedIndexes asSet equals: { 1. 5. 6 } asSet.
	s deselectIndexes: { 5. 6 }.
	self assert: s selectedIndexes asSet equals: { 1.  } asSet
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testEquals [

	| s |
	s := ToBasicListSelectionModel new.
	self assert: s equals: ToBasicListSelectionModel new.

]

{ #category : #tests }
ToBasicListSelectionModelTest >> testFirstIndex [

	| s |
	s := ToBasicListSelectionModel new.
	self assert: s firstIndex equals: 0.
	s itemCountGetter: [ 100 ].
	self assert: s firstIndex equals: 0.
	s selectIndexes: #( 4 6 8).
	self assert: s firstIndex equals: 4.
	s selectAll.
	self assert: s firstIndex equals: 1.

	
	
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testInitialize [ 

	| s |
	s := ToBasicListSelectionModel new.
	self assert: s isEmpty.
	self assert: (s underlyingModel isKindOf: BlCompositeSelection ).
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testIsEmpty [

	| s |
	s := ToBasicListSelectionModel new.
	self assert: s isEmpty

]

{ #category : #tests }
ToBasicListSelectionModelTest >> testItemCount [

	| s |
	s := ToBasicListSelectionModel new onInstalledIn: self.
	self assert: s itemCount equals: self itemCount.
	s underlyingModel selectIndex: 1.
	s assert: (s containsIndex: 1)
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testItemCountGetter [

	| s |
	s := ToBasicListSelectionModel new onInstalledIn: self.
	self assert: s itemCount equals: s itemCountGetter value.
	s itemCountGetter: [ 1000 ].
	self assert: s itemCount equals: 1000.
	

]

{ #category : #tests }
ToBasicListSelectionModelTest >> testLastIndex [

	| s |
	s := ToBasicListSelectionModel new.
	self assert: s lastIndex equals: 0.
	s itemCountGetter: [ 100 ].
	self assert: s lastIndex equals: 0.
	s selectIndexes: #( 4 6 8 ).
	self assert: s lastIndex equals: 8.
	s selectAll.
	self assert: s lastIndex equals: 100
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testOnInstalledIn [

	| s |
	s := ToBasicListSelectionModel new.
	s onInstalledIn: self.
	self assert: s itemCountGetter notNil.
	self assert: s itemCountGetter value equals: self itemCount 
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testOnUninstalledIn [

	| s |
	s := ToBasicListSelectionModel new.
	s onInstalledIn: self.
	s onUninstalledIn: self.
	self should: [ s itemCountGetter ] raise: Error.
	self should: [ s itemCount ] raise: Error
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testSelectAll [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 100.
	s selectAll.
	self assert: s lastIndex equals: 100.
	s selectIndex: 10.
	s selectAll.
	self assert: s lastIndex equals: 100.

]

{ #category : #tests }
ToBasicListSelectionModelTest >> testSelectIndex [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 100.
	s selectIndex: 1.
	s selectIndex: 5.
	s selectIndex: 6.
	self assert: s selectedIndexes equals: { 1. 5. 6 }.
	s selectIndex: 10.
	s selectIndex: 50.
	s selectIndex: 60.
	self assert: s selectedIndexes equals: { 1. 5. 6. 10. 50. 60 }
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testSelectIndexTo [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 100.
	s selectIndex: 5 to: 9.
	self assert: s selectedIndexes equals: { 5. 6. 7. 8. 9 }.
	s 	selectIndex: 15 to: 10.
	self assert: s selectedIndexes equals: { 5. 6. 7. 8. 9. 10. 11. 12. 13. 14. 15 }
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testSelectIndexes [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 100.
	s selectIndexes: { 1. 5. 6 }.
	self assert: s selectedIndexes equals: { 1. 5. 6 }.
	s selectIndexes: { 10. 50. 60 }.
	self assert: s selectedIndexes equals: { 1. 5. 6. 10. 50. 60 }
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testSelectedIndexesCollect [

	| s collected |
	s := ToBasicListSelectionModel new.
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
ToBasicListSelectionModelTest >> testSelectedIndexesCount [

	| s |
	s := ToBasicListSelectionModel new.
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
ToBasicListSelectionModelTest >> testSelectedIndexesDo [

	| s count |
	s := ToBasicListSelectionModel new.
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
ToBasicListSelectionModelTest >> testSelectedItemCount [

	| s |
	s := ToBasicListSelectionModel new onInstalledIn: self.
	self assert: s selectedIndexesCount equals: 0.
	s selectIndex: 1.
	self assert: s selectedIndexesCount equals: 1.
	s selectAll.
	self assert: s selectedIndexesCount equals: self itemCount.
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testShiftFrom [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 100.
	s selectIndexes: { 1. 5. 6 }.
	self assert: s selectedIndexes  equals: { 1. 5. 6 }.
	s shift: 1 from: 1.
	self assert: s selectedIndexes  equals: { 2. 6. 7 } .
	s shift: -1 from: 1.
	self assert: s selectedIndexes  equals: { 1. 5. 6 }.

]

{ #category : #tests }
ToBasicListSelectionModelTest >> testShiftFrom10 [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 200.
	s selectIndexes: { 4. 5. 7. 8. 10. 11 }.
	{ 4. 5. 7. 8. 10. 11 } do: [ :idx | s shift: -1 from: idx ].
	self assert: s selectedIndexes  equals: { 3. 4. 5. 6. 7 }
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testShiftFrom2 [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 100.
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
ToBasicListSelectionModelTest >> testShiftFrom3 [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 100.
	s selectIndexes: { 2. 3 }.
	s shift: -2 from: 3.
	self assert: s selectedIndexes  equals: { 1 }.
	s shift: -1 from: 1.
	self assert: s selectedIndexes  equals: {  }.





]

{ #category : #tests }
ToBasicListSelectionModelTest >> testShiftFrom4 [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 100.
	s selectIndexes: { 1. 5. 6 }.
	self assert: s selectedIndexes  equals: { 1. 5. 6 }.
	s shift: 1 from: 1.
	self assert: s selectedIndexes  equals: { 2. 6. 7 } .

]

{ #category : #tests }
ToBasicListSelectionModelTest >> testShiftFrom5 [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 100.
	s selectIndexes: { 2. 6. 7 }.
	s shift: 1 from: 6.
	self assert: s selectedIndexes  equals: { 2. 7. 8 }
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testShiftFrom6 [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 2.
	s selectIndexes: { 1 }.
	s shift: -1 from: 2.
	self assert: s selectedIndexes  equals: { 1 }
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testShiftFrom7 [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 200.
	s selectIndexes: { 3 }.
	s shift: -1 from: 4.
	self assert: s selectedIndexes  equals: { 3 }
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testShiftFrom8 [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 200.
	s selectIndexes: { 3 }.
	s shift: 1 from: 1.
	self assert: s selectedIndexes  equals: { 4 }
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testShiftFrom9 [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 200.
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
ToBasicListSelectionModelTest >> testShiftFrom9bis [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 200.
	s selectIndexes: { 3. 4. 5. 6. 7. 8 }.
	s shift: -1 from: 8.
	self assert: s selectedIndexes  equals: { 3. 4. 5. 6. 7 }.
	s shift: -1 from: 10.
	self assert: s selectedIndexes  equals: { 3. 4. 5. 6. 7 }.
	s shift: -1 from: 11.
	self assert: s selectedIndexes  equals: { 3. 4. 5. 6. 7 }
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testShiftFrom9bis2 [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 200.
	s selectIndexes: { 4. 5. 7}.
	s shift: -1 from: 4.
	self assert: s selectedIndexes  equals: { 3. 4. 6}.
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testUnderlyingModel [

	| s |
	s := ToBasicListSelectionModel new.
	self assert: (s underlyingModel isKindOf: BlCompositeSelection)
]

{ #category : #tests }
ToBasicListSelectionModelTest >> testselectedIndexes [

	| s |
	s := ToBasicListSelectionModel new itemCountGetter: 100.
	self assert: s selectedIndexes equals: #(  ).
	s selectAll.
	self assert: s selectedIndexes equals: (1 to: 100)
]
