"
A ToTreeDataAccessorTest is a test class for testing the behavior of ToTreeDataAccessor
"
Class {
	#name : #ToTreeDataAccessorTest,
	#superclass : #TestCase,
	#instVars : [
		'tree'
	],
	#category : #'Toplo-Widget-Tree-Tests-Core'
}

{ #category : #running }
ToTreeDataAccessorTest >> setUp [ 

	super setUp.
	tree := ToTreeElement new.
	
	
]

{ #category : #'tests - adding' }
ToTreeDataAccessorTest >> testAddAfter [

	tree dataAccessor addAll: #(1 2 3 4).
	tree dataAccessor add: 88 after: 1.
	self assert: tree dataAccessor asArray equals: #(1 88 2 3 4).
	tree dataAccessor add: 99 after: 2.
	self assert: tree dataAccessor asArray equals: #(1 88 2 99 3 4).
	self assert: (tree dataSource collect: #unwrappedDataItem) asArray equals: #(1 88 2 99 3 4)
]

{ #category : #'tests - adding' }
ToTreeDataAccessorTest >> testAddAfterIndex [

	tree dataAccessor addAll: #(1 2 3 4).
	tree dataAccessor add: 88 afterIndex: 0.
	self assert: tree dataAccessor asArray equals: #(88 1 2 3 4).
	tree dataAccessor add: 99 afterIndex: 5.
	self assert: tree dataAccessor asArray equals: #(88 1 2 3 4 99).
	tree dataAccessor add: 89 afterIndex: 4.
	self assert: tree dataAccessor asArray equals: #(88 1 2 3 89 4 99).
	self assert: (tree dataSource collect: #unwrappedDataItem) asArray equals: #(88 1 2 3 89 4 99)
]

{ #category : #'tests - adding' }
ToTreeDataAccessorTest >> testAddAll [
	"Allows one to add each element of an OrderedCollection at the end of another
	 OrderedCollection"


	tree dataAccessor addAll: #(1 2 3 4).
	tree dataAccessor addAll: #(5 6 7 8 9).
	self assert: tree dataAccessor asArray equals: #(1 2 3 4 5 6 7 8 9).
	self assert: (tree dataSource collect: #unwrappedDataItem) asArray equals: #(1 2 3 4 5 6 7 8 9)
]

{ #category : #'tests - adding' }
ToTreeDataAccessorTest >> testAddAllAfterIndex [
	"Allows one to add each element of an OrderedCollection at the end of another
	 OrderedCollection"

	tree dataAccessor addAll: #( 1 2 3 4 ).
	tree dataAccessor addAll: #( 5 6 7 8 9 ) afterIndex: 2.
	self assert: tree dataAccessor asArray equals: #( 1 2 5 6 7 8 9 3 4 ).
	self
		assert: (tree dataSource collect: #unwrappedDataItem) asArray
		equals: #( 1 2 5 6 7 8 9 3 4 ).
		
	tree dataAccessor addAll: #( -1 -2 -3 ) afterIndex: 4.
	self assert: tree dataAccessor asArray equals: #( 1 2 5 6 -1 -2 -3 7 8 9 3 4 ).
	self
		assert: (tree dataSource collect: #unwrappedDataItem) asArray
		equals: #( 1 2 5 6 -1 -2 -3 7 8 9 3 4 )
]

{ #category : #'tests - adding' }
ToTreeDataAccessorTest >> testAddAllFirst [
	"Allows one to add each element of an OrderedCollection at the beginning of another OrderedCollection "

	tree dataAccessor addAll: #(5 6 7 8 9).
	tree dataAccessor addAllFirst: #(1 2 3 4).
	self assert: tree dataAccessor asArray equals: #(1 2 3 4 5 6 7 8 9).
	self assert: (tree dataSource collect: #unwrappedDataItem) asArray equals: #(1 2 3 4 5 6 7 8 9)
]

{ #category : #'tests - adding' }
ToTreeDataAccessorTest >> testAddAllLast [
	"Allows one to add each element of an OrderedCollection at the beginning of another OrderedCollection"

	tree dataAccessor addAll: #(1 2 3 4).
	tree dataAccessor addAllLast: #(5 6 7 8 9).
	self assert: tree dataAccessor asArray equals: #(1 2 3 4 5 6 7 8 9).
	self assert: (tree dataSource collect: #unwrappedDataItem) asArray equals: #(1 2 3 4 5 6 7 8 9)
]

{ #category : #'tests - adding' }
ToTreeDataAccessorTest >> testAddBefore [

	tree dataAccessor addAll: #(1 2 3 4).
	tree dataAccessor add: 88 before: 1.
	self assert: tree dataAccessor asArray equals: #(88 1 2 3 4).
	tree dataAccessor add: 99 before: 2.
	self assert: tree dataAccessor asArray equals: #(88 1 99 2 3 4).
	self assert: (tree dataSource collect: #unwrappedDataItem) asArray equals: #(88 1 99 2 3 4)
]

{ #category : #'tests - adding' }
ToTreeDataAccessorTest >> testAddBeforeAndRemove [

	
	self testAddBefore.
	tree dataAccessor remove: 99.
	tree dataAccessor remove: 88.
	self assert: tree dataAccessor asArray equals:  #(1 2 3 4).
	self assert: (tree dataSource collect: #unwrappedDataItem) asArray equals: #(1 2 3 4)
]

{ #category : #'tests - adding' }
ToTreeDataAccessorTest >> testAddBeforeIndex [

	tree dataAccessor addAll: #(1 2 3 4).
	tree dataAccessor add: 88 beforeIndex: 1.
	self assert: tree dataAccessor asArray equals: #(88 1 2 3 4).
	tree dataAccessor add: 99 beforeIndex: 5.
	self assert: tree dataAccessor asArray equals: #(88 1 2 3 99 4).
	tree dataAccessor add: 89 beforeIndex: 4.
	self assert: tree dataAccessor asArray equals: #(88 1 2 89 3 99 4).
	self assert: (tree dataSource collect: #unwrappedDataItem) asArray equals: #(88 1 2 89 3 99 4) 
]

{ #category : #'tests - adding' }
ToTreeDataAccessorTest >> testAddDuplicateItem1 [

	| collection |
	tree dataAccessor addAll: #( 'Jim' 'Mary' 'John' 'Andrew' ).
	tree dataAccessor add: 'John' before: 'John'.
	collection := tree dataAccessor asArray.
	self assert: ((collection asBag occurrencesOf: 'John') = 2 and: [
			 (collection at: (collection indexOf: 'John') + 1)
			 = (collection at: (collection indexOf: 'John')) ]).
	self
		assert: (tree dataSource collect: #unwrappedDataItem) asArray
		equals: #( 'Jim' 'Mary' 'John' 'John' 'Andrew' )
]

{ #category : #'tests - adding' }
ToTreeDataAccessorTest >> testAddFirst [
	
	tree dataAccessor addAll: #(1 2 3 4).
	tree dataAccessor addFirst: 88.
	self assert: tree dataAccessor asArray equals: #(88 1 2 3 4).
	tree dataAccessor addFirst: 99.
	self assert: tree dataAccessor asArray equals: #(99 88 1 2 3 4).
	self assert: (tree dataSource collect: #unwrappedDataItem) asArray equals: #(99 88 1 2 3 4)
]

{ #category : #'tests - adding' }
ToTreeDataAccessorTest >> testAddLast [

	tree dataAccessor addAll: #( 1 2 3 4 ).
	tree dataAccessor addLast: 88.
	self assert: tree dataAccessor asArray equals: #( 1 2 3 4 88 ).
	tree dataAccessor addLast: 99.
	self assert: tree dataAccessor asArray equals: #( 1 2 3 4 88 99 ).
	self
		assert: (tree dataSource collect: #unwrappedDataItem) asArray
		equals: #( 1 2 3 4 88 99 )
]

{ #category : #'tests - enumerating' }
ToTreeDataAccessorTest >> testAllSatisfy [

	| c |
	tree dataAccessor addAll: #(1 2 3 4).
	c := OrderedCollection new.
	self assert: (tree dataAccessor allSatisfy: [ :item | item < 10 ]).
	self deny: (tree dataAccessor allSatisfy: [ :item | item isZero ]).
]

{ #category : #'tests - enumerating' }
ToTreeDataAccessorTest >> testAnySatisfy [ 

	| c |
	tree dataAccessor addAll: #(1 2 3 4).
	c := OrderedCollection new.
	self assert: (tree dataAccessor anySatisfy: [ :item | item < 2 ]).
	self deny: (tree dataAccessor anySatisfy: [ :item | item isZero ]).
]

{ #category : #'tests - accessing' }
ToTreeDataAccessorTest >> testAt [

	tree dataAccessor addAll: #('Jim' 'Mary' 'John' 'Andrew').
	self assert: (tree dataSource at: 1) unwrappedDataItem equals: 'Jim'.
	self assert: (tree dataSource at: 2) unwrappedDataItem equals: 'Mary'.
	self assert: (tree dataAccessor at: 1) equals: 'Jim'.
	self assert: (tree dataAccessor at: 2) equals: 'Mary'
]

{ #category : #'tests - accessing' }
ToTreeDataAccessorTest >> testAtPut [
	"Allows one to replace an element but not at an off range index"

	| wrapper |
	tree dataAccessor initializeWith: #( 1 2 3 4 ).
	wrapper := tree dataSource at: 2.
	tree dataAccessor at: 2 put: 5.
	self assert: (tree dataAccessor at: 2) equals: 5.
	self deny: (tree dataSource at: 2) identicalTo: wrapper
]

{ #category : #'tests - enumerating' }
ToTreeDataAccessorTest >> testCollect [

	| c |
	tree dataAccessor addAll: #(1 2 3 4).
	c := (tree dataAccessor collect: [ :item | item * 2 ]).
	self assert: c  equals: #(2 4 6 8) asOrderedCollection
]

{ #category : #'tests - concatenation' }
ToTreeDataAccessorTest >> testConcatenation [

	| result |
	tree dataAccessor addAll: #( 1 2 3 4 ).
	result := tree dataAccessor , #( 5 6 7 8 9 ).
	self
		assert: result
		equals: #( 1 2 3 4 5 6 7 8 9 ) asOrderedCollection.
	self assert: (tree dataSource collect: #unwrappedDataItem) asArray equals: #( 1 2 3 4 ).
]

{ #category : #'tests - copying' }
ToTreeDataAccessorTest >> testCopyFromTo [
	"Allows one to create a copy of the receiver that contains elements from position start to end"

	| c2 c3 |
	tree dataAccessor addAll: #(1 2 3 4).
	c2 := tree dataAccessor copyFrom: 1 to: 2.
	self assert: c2 equals: #(1 2) asOrderedCollection.
	self should: [ tree dataAccessor copyFrom: 10 to: 20 ] raise: Error.

	c3 := tree dataAccessor copyFrom: 4 to: 2.
	self assert: c3 isEmpty.

	self should: [ tree dataAccessor copyFrom: 4 to: 5 ] raise: Error
]

{ #category : #'tests - copying' }
ToTreeDataAccessorTest >> testCopyReplaceFromToWith [
	"Allows one to create a copy from the receiver which elements between start and end of the receiver being replace by element of the collection after with:"

	| c2 c3 c4 |
	tree dataAccessor addAll: #( 1 2 3 4 ).
	c2 := #( 5 6 7 8 9 ) asOrderedCollection.
	c3 := c2 copyReplaceFrom: 1 to: 2 with: tree dataAccessor.
	self assert: c3 equals: #( 1 2 3 4 7 8 9 ) asOrderedCollection.
	self
		should: [ c2 copyReplaceFrom: 3 to: 1 with: tree dataAccessor ]
		raise: Error.

	c4 := c2 copyReplaceFrom: 10 to: 25 with: tree dataAccessor.
	self assert: c4 equals: #( 5 6 7 8 9 1 2 3 4 ) asOrderedCollection
]

{ #category : #'tests - copying' }
ToTreeDataAccessorTest >> testCopyReplaceFromToWith2 [
	"Allows one to create a copy from the receiver which elements between start and end of the receiver being replace by element of the collection after with:"

	| tree2 c3 c4 |
	tree2 := ToTreeElement new.
	tree dataAccessor addAll: #( 1 2 3 4 ).
	tree2 dataAccessor addAll: #( 5 6 7 8 9 ).
	c3 := tree2 dataAccessor
		      copyReplaceFrom: 1
		      to: 2
		      with: tree dataAccessor.
	self assert: c3 equals: #( 1 2 3 4 7 8 9 ) asOrderedCollection.
	self
		should: [
		tree2 dataAccessor copyReplaceFrom: 3 to: 1 with: tree dataAccessor ]
		raise: Error.

	c4 := tree2 dataAccessor
		      copyReplaceFrom: 10
		      to: 25
		      with: tree dataAccessor.
	self assert: c4 equals: #( 5 6 7 8 9 1 2 3 4 ) asOrderedCollection
]

{ #category : #'tests - enumerating' }
ToTreeDataAccessorTest >> testDetectIfNone [

	| found |
	tree dataAccessor addAll: #(1 2 3 4).
	found := tree dataAccessor detect: [ :item | item = 3 ] ifNone: [].
	self assert: found equals: 3.
	found := tree dataAccessor detect: [ :item | item = 0 ] ifNone: [].
	self assert: found isNil


]

{ #category : #'tests - enumerating' }
ToTreeDataAccessorTest >> testDo [

	| c |
	tree dataAccessor addAll: #(1 2 3 4).
	c := OrderedCollection new.
	tree dataAccessor do: [ :item | c add: item ].
	self assert: c asArray equals: tree dataAccessor asArray

]

{ #category : #'tests - accessing' }
ToTreeDataAccessorTest >> testFirstSecondThirdFourthFifth [
	"Allows one to replace an element but not at an off range index"

	tree dataAccessor initializeWith: #( 1 2 3 4 5).
	self assert: (tree dataAccessor first) equals: 1.
	self assert: (tree dataAccessor second) equals: 2.
	self assert: (tree dataAccessor third) equals: 3.
	self assert: (tree dataAccessor fourth) equals: 4.
	self assert: (tree dataAccessor fifth) equals: 5.

]

{ #category : #'tests - index access' }
ToTreeDataAccessorTest >> testIndexOf [

	tree dataAccessor addAll: #(1 20 30).
	self assert: (tree dataAccessor indexOf: 1) equals: 1.
	self assert: (tree dataAccessor indexOf: 20) equals: 2.
	self assert: (tree dataAccessor indexOf: 30) equals: 3.
	self assert: (tree dataAccessor indexOf: -1) equals: 0.
	self assert: (tree dataAccessor indexOf: 40) equals: 0
]

{ #category : #'tests - index access' }
ToTreeDataAccessorTest >> testIndexOfIfAbsent [

	tree dataAccessor addAll: #(1 20 30).
	self assert: (tree dataAccessor indexOf: 1 ifAbsent: 10) equals: 1.
	self assert: (tree dataAccessor indexOf: 20 ifAbsent: 10) equals: 2.
	self assert: (tree dataAccessor indexOf: 30 ifAbsent: 10 ) equals: 3.
	self assert: (tree dataAccessor indexOf: -1 ifAbsent: 10) equals: 10.
	self assert: (tree dataAccessor indexOf: 40 ifAbsent: 10) equals: 10
]

{ #category : #'tests - index access' }
ToTreeDataAccessorTest >> testIndexOfStartingAt [


	| element |
	tree dataAccessor addAll: #(1 20 30).
	element := tree dataAccessor first.
	self assert: (tree dataAccessor
			indexOf: element
			startingAt: 2
			ifAbsent: [ 99 ]) equals: 99.
	self assert: (tree dataAccessor
			indexOf: element
			startingAt: 1
			ifAbsent: [ 99 ]) equals: 1.
	self assert: (tree dataAccessor
			indexOf: -1
			startingAt: 1
			ifAbsent: [ 99 ]) equals: 99
]

{ #category : #'tests - accessing' }
ToTreeDataAccessorTest >> testLast [
	"Allows one to replace an element but not at an off range index"

	tree dataAccessor initializeWith: #( 1 2 3 4 5).
	self assert: (tree dataAccessor last) equals: 5.
	self assert: (tree dataAccessor last: 3) asArray equals: #(3 4 5).
	self assert: (tree dataSource collect: #unwrappedDataItem) asArray equals: #( 1 2 3 4 5)
]

{ #category : #'tests - adding' }
ToTreeDataAccessorTest >> testRegisterActionLink [

	tree dataAccessor addAll: #(1 2 3 4).
	tree dataAccessor add: 88.
	self assert: tree dataAccessor asOrderedCollection equals: #(1 2 3 4 88) asOrderedCollection.
	tree dataAccessor add: 99.
	self assert: tree dataAccessor asOrderedCollection equals: #(1 2 3 4 88 99) asOrderedCollection.
	self assert: (tree dataSource collect: #unwrappedDataItem) asArray equals: #(1 2 3 4 88 99)
]

{ #category : #'tests - copying' }
ToTreeDataAccessorTest >> testReversed [

	| collection2 |
	tree dataAccessor addAll: #( 'Jim' 'Mary' 'John' 'Andrew' ).
	collection2 := tree dataAccessor reversed.
	self assert: collection2 first equals: 'Andrew'.
	self assert: collection2 last equals: 'Jim'
]
