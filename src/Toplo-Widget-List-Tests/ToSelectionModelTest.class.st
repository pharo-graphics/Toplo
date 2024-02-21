"
A ToSelectionModelTest is a test class for testing the behavior of ToSelectionModel
"
Class {
	#name : #ToSelectionModelTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-List-Tests-Selection-Model'
}

{ #category : #accessing }
ToSelectionModelTest >> itemCount [

	^ 1000
]

{ #category : #tests }
ToSelectionModelTest >> testContainsIndex [

	| s |
	s := ToSelectionModel new.
	self deny: (s containsIndex: 1).
	s selectIndex: 1.
	s assert: (s containsIndex: 1).

]

{ #category : #tests }
ToSelectionModelTest >> testCopyCompositeModel [

	| s c |
	s := ToSelectionModel new.
	c := s copy.
	self deny: s underlyingModel identicalTo: c underlyingModel.
	self assert: c equals: s
]

{ #category : #tests }
ToSelectionModelTest >> testDeselectAll [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s deselectAll.
	self assert: s isEmpty .
	s selectIndex: 10.
	s deselectAll.
	self assert: s isEmpty

]

{ #category : #tests }
ToSelectionModelTest >> testDeselectAllIndexes [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectAllIndexes: { 1. 5. 6 }.
	self assert: s selectedIndexes asSet equals: { 1. 5. 6 } asSet.
	s deselectAllIndexes: { 10. 50. 60 }.
	self assert: s selectedIndexes asSet equals: { 1. 5. 6 } asSet.
	s deselectAllIndexes: { 5. 6 }.
	self assert: s selectedIndexes asSet equals: { 1.  } asSet
]

{ #category : #tests }
ToSelectionModelTest >> testDeselectAllIndexesWithAWholeSelection [

	| s |
	s := ToSelectionModel new itemCountGetter: 10.
	s selectAll.
	" item count that is necessary in that case "
	s deselectAllIndexes: { 2. 4. 6 }.
	self assert: s selectedIndexes equals: { 1. 3. 5. 7. 8. 9. 10 }
]

{ #category : #tests }
ToSelectionModelTest >> testDeselectAllIndexesWithAWholeSelection2 [

	| s |
	s := ToSelectionModel new.
	" no way to get item count that is necessary in that case -> Error"
	self should: [s selectAll] raise: Error.
	s deselectAllIndexes: { 2. 4. 6 }.
	self assert: s isEmpty

]

{ #category : #tests }
ToSelectionModelTest >> testDeselectIndex [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectAllIndexes: { 1. 5. 6 }.
	self assert: s selectedIndexes asSet equals: { 1. 5. 6 } asSet.
	s deselectIndex: 10.
	self assert: s selectedIndexes asSet equals: { 1. 5. 6 } asSet.
	s deselectIndex: 5.
	s deselectIndex: 6.
	self assert: s selectedIndexes asSet equals: { 1.  } asSet
]

{ #category : #tests }
ToSelectionModelTest >> testDeselectIndexTo [

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
ToSelectionModelTest >> testEquals [

	| s |
	s := ToSelectionModel new.
	self assert: s equals: ToSelectionModel new.

]

{ #category : #tests }
ToSelectionModelTest >> testFirstIndex [

	| s |
	s := ToSelectionModel new.
	self assert: s firstIndex equals: 0.
	s itemCountGetter: [ 100 ].
	self assert: s firstIndex equals: 0.
	s selectAllIndexes: #( 4 6 8).
	self assert: s firstIndex equals: 4.
	s selectAll.
	self assert: s firstIndex equals: 1.

	
	
]

{ #category : #tests }
ToSelectionModelTest >> testInitialize [ 

	| s |
	s := ToSelectionModel new.
	self assert: s isEmpty.
	self assert: (s underlyingModel isKindOf: BlCompositeSelection ).
]

{ #category : #tests }
ToSelectionModelTest >> testIsEmpty [

	| s |
	s := ToSelectionModel new.
	self assert: s isEmpty

]

{ #category : #tests }
ToSelectionModelTest >> testItemCount [

	| s |
	s := ToSelectionModel new onInstalledIn: self.
	self assert: s itemCount equals: self itemCount.
	s underlyingModel selectIndex: 1.
	s assert: (s containsIndex: 1)
]

{ #category : #tests }
ToSelectionModelTest >> testItemCountGetter [

	| s |
	s := ToSelectionModel new onInstalledIn: self.
	self assert: s itemCount equals: s itemCountGetter value.
	s itemCountGetter: [ 1000 ].
	self assert: s itemCount equals: 1000.
	

]

{ #category : #tests }
ToSelectionModelTest >> testLastIndex [

	| s |
	s := ToSelectionModel new.
	self assert: s lastIndex equals: 0.
	s itemCountGetter: [ 100 ].
	self assert: s lastIndex equals: 0.
	s selectAllIndexes: #( 4 6 8 ).
	self assert: s lastIndex equals: 8.
	s selectAll.
	self assert: s lastIndex equals: 100
]

{ #category : #tests }
ToSelectionModelTest >> testOnInstalledIn [

	| s |
	s := ToSelectionModel new.
	s onInstalledIn: self.
	self assert: s itemCountGetter notNil.
	self assert: s itemCountGetter value equals: self itemCount 
]

{ #category : #tests }
ToSelectionModelTest >> testOnUninstalledIn [

	| s |
	s := ToSelectionModel new.
	s onInstalledIn: self.
	s onUninstalledIn: self.
	self should: [ s itemCountGetter ] raise: Error.
	self should: [ s itemCount ] raise: Error
]

{ #category : #tests }
ToSelectionModelTest >> testSelectAll [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectAll.
	self assert: s lastIndex equals: 100.
	s selectIndex: 10.
	s selectAll.
	self assert: s lastIndex equals: 100.

]

{ #category : #tests }
ToSelectionModelTest >> testSelectAllIndexes [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectAllIndexes: { 1. 5. 6 }.
	self assert: s selectedIndexes equals: { 1. 5. 6 }.
	s selectAllIndexes: { 10. 50. 60 }.
	self assert: s selectedIndexes equals: { 1. 5. 6. 10. 50. 60 }
]

{ #category : #tests }
ToSelectionModelTest >> testSelectIndex [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
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
ToSelectionModelTest >> testSelectIndexTo [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectIndex: 5 to: 9.
	self assert: s selectedIndexes equals: { 5. 6. 7. 8. 9 }.
	s 	selectIndex: 15 to: 10.
	self assert: s selectedIndexes equals: { 5. 6. 7. 8. 9. 10. 11. 12. 13. 14. 15 }
]

{ #category : #tests }
ToSelectionModelTest >> testSelectedIndexesCollect [

	| s collected |
	s := ToSelectionModel new.
	s itemCountGetter: [ 100 ].
	collected := s selectedIndexesCollect: [ :idx | idx ].
	self assert: collected equals: #(  ).
	s selectAllIndexes: #( 4 6 8 ).
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
ToSelectionModelTest >> testSelectedIndexesCount [

	| s |
	s := ToSelectionModel new.
	s itemCountGetter: [ 100 ].
	self assert: s selectedIndexesCount equals: 0.
	s selectAllIndexes: #( 4 6 8 ).
	self assert: s selectedIndexesCount equals: 3.
	s deselectAll.
	self assert: s selectedIndexesCount equals: 0.
	s selectAll.
	self assert: s selectedIndexesCount equals: 100
]

{ #category : #tests }
ToSelectionModelTest >> testSelectedIndexesDo [

	| s count |
	s := ToSelectionModel new.
	s itemCountGetter: [ 100 ].
	count := 0.
	s selectedIndexesDo: [ :idx | count := count + 1 ].
	self assert: count equals: 0.
	s selectAllIndexes: #( 4 6 8 ).
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
ToSelectionModelTest >> testSelectedItemCount [

	| s |
	s := ToSelectionModel new onInstalledIn: self.
	self assert: s selectedIndexesCount equals: 0.
	s selectIndex: 1.
	self assert: s selectedIndexesCount equals: 1.
	s selectAll.
	self assert: s selectedIndexesCount equals: self itemCount.
]

{ #category : #tests }
ToSelectionModelTest >> testShiftFrom [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectAllIndexes: { 1. 5. 6 }.
	self assert: s selectedIndexes  equals: { 1. 5. 6 }.
	s shift: 1 from: 1.
	self assert: s selectedIndexes  equals: { 2. 6. 7 } .
	s shift: -1 from: 1.
	self assert: s selectedIndexes  equals: { 1. 5. 6 }.

]

{ #category : #tests }
ToSelectionModelTest >> testShiftFrom10 [

	| s |
	s := ToSelectionModel new itemCountGetter: 200.
	s selectAllIndexes: { 4. 5. 7. 8. 10. 11 }.
	{ 4. 5. 7. 8. 10. 11 } do: [ :idx | s shift: -1 from: idx ].
	self assert: s selectedIndexes  equals: { 3. 4. 5. 6. 7 }
]

{ #category : #tests }
ToSelectionModelTest >> testShiftFrom2 [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectAllIndexes: { 1. 5. 6 }.
	self assert: s selectedIndexes  equals: { 1. 5. 6 }.
	s shift: 3 from: 5.
	self assert: s selectedIndexes  equals: { 1. 8. 9 } .
	s shift: -3 from: 1.
	self assert: s selectedIndexes  equals: { 5. 6 }.
	s shift: -3 from: 1.
	self assert: s selectedIndexes  equals: { 2. 3 }


]

{ #category : #tests }
ToSelectionModelTest >> testShiftFrom3 [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectAllIndexes: { 2. 3 }.
	s shift: -2 from: 3.
	self assert: s selectedIndexes  equals: { 1 }.
	s shift: -1 from: 1.
	self assert: s selectedIndexes  equals: {  }.





]

{ #category : #tests }
ToSelectionModelTest >> testShiftFrom4 [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectAllIndexes: { 1. 5. 6 }.
	self assert: s selectedIndexes  equals: { 1. 5. 6 }.
	s shift: 1 from: 1.
	self assert: s selectedIndexes  equals: { 2. 6. 7 } .

]

{ #category : #tests }
ToSelectionModelTest >> testShiftFrom5 [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	s selectAllIndexes: { 2. 6. 7 }.
	s shift: 1 from: 6.
	self assert: s selectedIndexes  equals: { 2. 7. 8 }
]

{ #category : #tests }
ToSelectionModelTest >> testShiftFrom6 [

	| s |
	s := ToSelectionModel new itemCountGetter: 2.
	s selectAllIndexes: { 1 }.
	s shift: -1 from: 2.
	self assert: s selectedIndexes  equals: { 1 }
]

{ #category : #tests }
ToSelectionModelTest >> testShiftFrom7 [

	| s |
	s := ToSelectionModel new itemCountGetter: 200.
	s selectAllIndexes: { 3 }.
	s shift: -1 from: 4.
	self assert: s selectedIndexes  equals: { 3 }
]

{ #category : #tests }
ToSelectionModelTest >> testShiftFrom8 [

	| s |
	s := ToSelectionModel new itemCountGetter: 200.
	s selectAllIndexes: { 3 }.
	s shift: 1 from: 1.
	self assert: s selectedIndexes  equals: { 4 }
]

{ #category : #tests }
ToSelectionModelTest >> testShiftFrom9 [

	| s |
	s := ToSelectionModel new itemCountGetter: 200.
	s selectAllIndexes: { 4. 5. 7. 8. 10. 11 }.
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
	"{ 4. 5. 7. 8. 10. 11 } do: [ :idx | s shift: -1 from: idx ].
	self assert: s selectedIndexes  equals: { 3. 4. 6. 7. 9. 10 }
	{ 4. 5. 7. 8. 10. 11 } do: [ :idx | s shift: -1 from: idx ].
	self assert: s selectedIndexes  equals: { 3. 4. 6. 7. 9. 10 }"
]

{ #category : #tests }
ToSelectionModelTest >> testUnderlyingModel [

	| s |
	s := ToSelectionModel new.
	self assert: (s underlyingModel isKindOf: BlCompositeSelection)
]

{ #category : #tests }
ToSelectionModelTest >> testselectedIndexes [

	| s |
	s := ToSelectionModel new itemCountGetter: 100.
	self assert: s selectedIndexes equals: #(  ).
	s selectAll.
	self assert: s selectedIndexes equals: (1 to: 100)
]
