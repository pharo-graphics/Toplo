"
A ToObservableListTest is a test class for testing the behavior of ToObservableList
"
Class {
	#name : #ToObservableCollectionTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Collection'
}

{ #category : #'tests - adding' }
ToObservableCollectionTest >> testAdd [

	| l i|
	l := ToObservableCollection new.
	
	l whenAddChangeDo: [ :ann | i := ann interval ].
	l add: 88.
	self
		assert: l asOrderedCollection
		equals: #( 88 ) asOrderedCollection.
	self assert: i notNil.
	self assert: i equals: (1 to: 1).
	l add: 99.
	self assert: i equals: (2 to: 2).
	self
		assert: l asOrderedCollection
		equals: #( 88 99 ) asOrderedCollection
]

{ #category : #'tests - adding' }
ToObservableCollectionTest >> testAddAfter [

	| l i |
	l := ToObservableCollection newFrom: #( 1 2 3 4 ).
		
	l whenAddChangeDo: [ :ann | i := ann interval ].
		
	l add: 88 after: 1.
	
	self assert: i notNil.
	self assert: i equals: (2 to: 2).

	self
		assert: l asOrderedCollection
		equals: #( 1 88 2 3 4 ) asOrderedCollection.

	l add: 99 after: 2.
	
	self assert: i equals: (4 to: 4).

	self
		assert: l asOrderedCollection
		equals: #( 1 88 2 99 3 4 ) asOrderedCollection
]

{ #category : #'tests - adding' }
ToObservableCollectionTest >> testAddAfterIndex [
	| coll |
	coll := ToObservableCollection newFrom: #( 1 2 3 4 ).
	coll add: 77 afterIndex: 0.
	self assert: coll asArray equals: #(77 1 2 3 4).
	coll add: 88 afterIndex: 2.
	self assert: coll asArray equals: #(77 1 88 2 3 4). 
	coll add: 99 afterIndex: coll size.
	self assert: coll asArray equals: #(77 1 88 2 3 4 99). 
	self should: [ coll add: 666 afterIndex: -1 ] raise: Error.
	self should: [ coll add: 666 afterIndex: coll size+1 ] raise: Error.
	
	"Now make room by removing first two and last two elements,
	and see if the illegal bounds test still fails"
	(coll first: 2), (coll last: 2) reversed do: [:e | coll remove: e].
	self should: [ coll add: 666 afterIndex: -1 ] raise: Error.
	self should: [ coll add: 666 afterIndex: coll size+1 ] raise: Error
]

{ #category : #'tests - adding' }
ToObservableCollectionTest >> testAddAll [
	"Allows one to add each element of an OrderedCollection at the end of another
	 OrderedCollection"

	| c1 c2 i |
	c1 := ToObservableCollection newFrom: #(1 2 3 4).
	c2 := ToObservableCollection newFrom: #(5 6 7 8 9).
	c1 whenAddChangeDo: [ :ann | i := ann interval ].
	c1 addAll: c2.
	self assert: c1 asArray equals: #(1 2 3 4 5 6 7 8 9).
	self assert: i equals: (5 to: 9)
]

{ #category : #'tests - adding' }
ToObservableCollectionTest >> testAddAllFirst [
	"Allows one to add each element of an OrderedCollection at the end of another
	 OrderedCollection"

	| 	c1 c2 i |
	c1 := ToObservableCollection new
		     addAll: #( 1 2 3 4 );
		     yourself.
	c2 := ToObservableCollection new
		     addAll: #(5 6 7 8 9);
		     yourself.
		
	c2 whenAddChangeDo: [ :ann | i := ann interval ].
		
	c2 addAllFirst: c1.
	self assert: c2 asOrderedCollection equals: #(1 2 3 4 5 6 7 8 9) asOrderedCollection.
	
	self assert: i equals: (1 to: 4)
	
]

{ #category : #'tests - adding' }
ToObservableCollectionTest >> testAddAllLast [
	"Allows one to add each element of an OrderedCollection at the end of another
	 OrderedCollection"

	| 	c1 c2 i |
	c1 := ToObservableCollection new
		     addAll: #( 1 2 3 4 );
		     yourself.
	c2 := ToObservableCollection new
		     addAll: #(5 6 7 8 9);
		     yourself.
		
	c1 whenAddChangeDo: [ :ann | i := ann interval ].
		
	c1 addAllLast: c2.
	self assert: c1 asOrderedCollection equals: #(1 2 3 4 5 6 7 8 9) asOrderedCollection.
	
	self assert: i equals: (5 to: 9)
	
]

{ #category : #'tests - adding' }
ToObservableCollectionTest >> testAddBefore [

	| l i |
	l := ToObservableCollection new
		     addAll: #( 1 2 3 4 );
		     yourself.
		
	l whenAddChangeDo: [ :ann | i := ann interval ].
		
	l add: 88 before: 1.
	
	self assert: i notNil.
	self assert: i equals: (1 to: 1).

	self
		assert: l asOrderedCollection
		equals: #(88 1 2 3 4) asOrderedCollection.

	l add: 99 before: 2.
	
	self assert: i equals: (3 to: 3).

	self
		assert: l asOrderedCollection
		equals: #(88 1 99 2 3 4) asOrderedCollection
]

{ #category : #'tests - adding' }
ToObservableCollectionTest >> testAddBeforeAndRemove [

	| l i initialCollection |
	l := ToObservableCollection new
		     addAll: #( 1 2 3 4 );
		     yourself.
		
	initialCollection := l copy.
			
	l whenAddChangeDo: [ :ann | i := ann interval ].
		
	l add: 88 before: 1.
	
	self assert: i notNil.
	self assert: i equals: (1 to: 1).

	self
		assert: l asOrderedCollection
		equals: #(88 1 2 3 4) asOrderedCollection.

	l add: 99 before: 2.
	
	self assert: i equals: (3 to: 3).
	
	l remove: 99.
	l remove: 88.
	
	self assert: l asArray equals: initialCollection asArray 
]

{ #category : #'tests - adding' }
ToObservableCollectionTest >> testAddBeforeIndex [

	| l i |
	l := ToObservableCollection new
		     addAll: #( 1 2 3 4 );
		     yourself.
		
	l whenAddChangeDo: [ :ann | i := ann interval ].
		
	l add: 88 beforeIndex: 1.
	
	self assert: i notNil.
	self assert: i equals: (1 to: 1).

	self
		assert: l asOrderedCollection
		equals: #(88 1 2 3 4) asOrderedCollection.

	l add: 99 beforeIndex: 3.
	
	self assert: i equals: (3 to: 3).

	self
		assert: l asOrderedCollection
		equals: #(88 1 99 2 3 4) asOrderedCollection
]

{ #category : #'tests - adding' }
ToObservableCollectionTest >> testAddFirst [

	| l i  |
	l := ToObservableCollection new
		     addAll: #( 1 2 3 4 );
		     yourself.
		
	l whenAddChangeDo: [ :ann | i := ann interval ].
		
	l addFirst: 88.
	
	self assert: i notNil.
	self assert: i equals: (1 to: 1).

	self
		assert: l asOrderedCollection
		equals: #(88 1 2 3 4) asOrderedCollection.

	i := nil.

	l addFirst: 99.
	
	self
		assert: l asOrderedCollection
		equals: #(99 88 1 2 3 4) asOrderedCollection.

	self assert: i equals: (1 to: 1)
]

{ #category : #'tests - adding' }
ToObservableCollectionTest >> testAddLast [

	| l i |
	l := ToObservableCollection new
		     addAll: #( 1 2 3 4 );
		     yourself.
		
	l whenAddChangeDo: [ :ann | i := ann interval ].
		
	l addLast: 88.
	
	self assert: i notNil.
	self assert: i equals: (5 to: 5).

	self
		assert: l asOrderedCollection
		equals: #(1 2 3 4 88) asOrderedCollection.

	i := nil.

	l addLast: 99.
	
	self
		assert: l asOrderedCollection
		equals: #(1 2 3 4 88 99) asOrderedCollection.

	self assert: i notNil.
	self assert: i equals: (6 to: 6)
]

{ #category : #'tests - converting' }
ToObservableCollectionTest >> testAsArray [

	| l |
	l := ToObservableCollection newFrom: #( 1 2 3 4 ).
	self assert: l asArray equals: #( 1 2 3 4 )

]

{ #category : #'tests - converting' }
ToObservableCollectionTest >> testAsOrderedCollection [ 

	| l |
	l := ToObservableCollection newFrom: #( 1 2 3 4 ).
	self assert: l asOrderedCollection equals: #( 1 2 3 4 ) asOrderedCollection 

]

{ #category : #'tests - accessing' }
ToObservableCollectionTest >> testAt [
	| collection |
	collection := ToObservableCollection newFrom: #('Jim' 'Mary' 'John' 'Andrew').
	self assert: (collection at: 1) equals: 'Jim'.
	self assert: (collection at: 2) equals: 'Mary'
]

{ #category : #'tests - accessing' }
ToObservableCollectionTest >> testAtPut [
	"Allows one to replace an element but not at an off range index"

	| c i |
	c := ToObservableCollection newFrom:  #(1 2 3 4).
	c whenUpdateChangeDo: [ :ann | i := ann interval ].
	c at: 2 put: 5.
	self assert: i equals: (2 to: 2).
	self assert: c asArray equals: #(1 5 3 4).
	self should: [ c at: 5 put: 8 ] raise: Error.
	self deny: c asArray equals: #(1 5 3 4 8)
]

{ #category : #'tests - adding' }
ToObservableCollectionTest >> testComma [

	| 	c1 c2 c3 |
	c1 := ToObservableCollection new
		     addAll: #( 1 2 3 4 );
		     yourself.
	c2 := ToObservableCollection new
		     addAll: #(5 6 7 8 9);
		     yourself.
		
	c3 := c1, c2.
	self assert: c3 size equals: (c1 size + c2 size).
	self assert: c3 asArray equals: #(1 2 3 4 5 6 7 8 9)
		

]

{ #category : #'tests - adding' }
ToObservableCollectionTest >> testConcatenation [

	| result index firstCollection secondCollection |
	firstCollection := ToObservableCollection newFrom: #( 1 2 3 4 ).
	secondCollection := ToObservableCollection newFrom: #( 5 6 7 8 9 ).
	result := firstCollection , secondCollection.
	"first part : "
	index := 1.
	firstCollection do: [ :each | 
		self assert: (firstCollection at: index) = each.
		index := index + 1 ].
	"second part : "
	1 to: secondCollection size do: [ :i | 
		self assert: (secondCollection at: i) = (result at: index).
		index := index + 1 ].
	"size : "
	self assert:
		result size = (firstCollection size + secondCollection size)
]

{ #category : #'tests - removing' }
ToObservableCollectionTest >> testRemove [

	"Allows one to remove an element from a collection at an index"

	| c1 i |
	c1 := ToObservableCollection newFrom: #( 2 3 4 6 ).
	c1 whenRemoveChangeDo: [ :ann | i := ann interval ].

	c1 remove: 3.
	self assert: i equals: (2 to: 2).

	self assert: c1 asArray equals: #( 2 4 6 ).
	self should: [ c1 remove: 10 ] raise: Error
]

{ #category : #'tests - removing' }
ToObservableCollectionTest >> testRemoveAll [

	"Allows one to remove all elements of a collection"

	| c1 c2 s2 i |
	c1 := ToObservableCollection newFrom: #( 2 3 4 6 ).

	c1 whenAddChangeDo: [ :ann | i := ann interval ].
	c1 addAll: (1 to: 200).
	self assert: i equals: (5 to: 204).

	c2 := c1 copy.
	s2 := c2 size.

	i := nil.

	c1 whenRemoveChangeDo: [ :ann | i := ann interval ].
	c1 removeAll.
	self assert: i equals: (1 to: 204).

	self assert: c1 size equals: 0.
	self
		assert: c2 size = s2
		description: 'the copy has not been modified'
]

{ #category : #'tests - removing' }
ToObservableCollectionTest >> testRemoveAt [

	"Allows one to remove an element from a collection at an index"

	| c1 i |
	c1 := ToObservableCollection newFrom: #( 2 3 4 6 ).
	c1 whenRemoveChangeDo: [ :ann | i := ann interval ].

	c1 removeAt: 2.
	self assert: i equals: (2 to: 2).

	self assert: c1 asArray equals: #( 2 4 6 ).
	self should: [ c1 removeAt: 10 ] raise: Error.
	self should: [ c1 removeAt: -1 ] raise: Error
]

{ #category : #'tests - removing' }
ToObservableCollectionTest >> testRemoveFirst [

	"Allows one to remove n element of a collection at the first"

	| c1 i |
	c1 := ToObservableCollection newFrom: #( 2 3 4 6 ).
	c1 whenRemoveChangeDo: [ :ann | i := ann interval ].

	c1 removeFirst: 1.
	self assert: i equals: (1 to: 1).

	self assert: c1 asArray equals: #( 3 4 6 ).
	c1 removeFirst: 2.
	self assert: i equals: (1 to: 2).

	self assert: c1 asArray equals: #( 6 ).
	self should: [ c1 removeFirst: 10 ] raise: Error
]

{ #category : #'tests - removing' }
ToObservableCollectionTest >> testRemoveFromTo [

	"Allows one to remove an element from a collection at an index"

	| c1 i |
	c1 := ToObservableCollection newFrom: #( 2 3 4 6 ).
	c1 whenRemoveChangeDo: [ :ann | i := ann interval ].

	c1 removeFrom: 2 to: 2.
	self assert: i equals: (2 to: 2).
	self assert: c1 size equals: 3.
	
	c1 addAll: (1 to: 100).
	c1 removeFrom: 2 to: 103.
	self assert: i equals: (2 to: 103).
	self assert: c1 size equals: 1.

	self assert: c1 asArray equals: #( 2  ).
	self should: [ c1 removeFrom: 10 to: 10] raise: Error.
	self should: [ c1 removeFrom: -1 to: 10] raise: Error
]

{ #category : #'tests - removing' }
ToObservableCollectionTest >> testRemoveLast [
	"Allows one to remove n element of a collection at the end"
	
	| c1 i |
	c1 := ToObservableCollection newFrom: #(2 3 4 6).
	c1 whenRemoveChangeDo: [ :ann | i := ann interval ].
	
	c1 removeLast: 1.
	self assert: i equals: (4 to: 4).
	
	self assert: c1 asArray equals: #(2 3 4).
	c1 removeLast: 2.
	self assert: i equals: (2 to: 3).

	self assert: c1 asArray equals: #(2).
	self should: [ c1 removeLast: 10 ] raise: Error
]

{ #category : #'tests - adding' }
ToObservableCollectionTest >> testReversed [

	| collection1 collection2 |
	collection1 := ToObservableCollection newFrom:
		               #( 'Jim' 'Mary' 'John' 'Andrew' ).
	collection2 := collection1 reversed.
	self assert: collection2 first equals: 'Andrew'.
	self assert: collection2 last equals: 'Jim'
]
