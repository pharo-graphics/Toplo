Class {
	#name : #ToObservableCollectionMirrorUpdaterTest,
	#superclass : #TestCase,
	#instVars : [
		'ocol',
		'mirror',
		'mirrorUpdater'
	],
	#category : #'Toplo-Tests-Core-Collection'
}

{ #category : #running }
ToObservableCollectionMirrorUpdaterTest >> setUp [ 

	super setUp.
	ocol := ToObservableCollection new.
	mirror := ToObservableCollection new.
	mirrorUpdater := ToObservableCollectionMirrorUpdater new.
	mirrorUpdater mirror: mirror.
	ocol addEventHandler: mirrorUpdater
]

{ #category : #'tests - adding' }
ToObservableCollectionMirrorUpdaterTest >> testAddAfter [

	| i |
	mirror addEventHandler: (BlEventHandler
			 on: ToCollectionAddEvent 
			 do: [ :ann | i := ann interval ]).

	ocol updateAllWith: #( 1 2 3 4 ).
	self assert: i notNil.
	self assert: i equals: (1 to: 4).

	ocol add: 88 after: 1.

	self
		assert: mirror asOrderedCollection
		equals: #( 1 88 2 3 4 ) asOrderedCollection.

	ocol add: 99 after: 2.

	self assert: i equals: (4 to: 4).

	self
		assert: mirror asOrderedCollection
		equals: #( 1 88 2 99 3 4 ) asOrderedCollection
]

{ #category : #'tests - adding' }
ToObservableCollectionMirrorUpdaterTest >> testAddAfterIndex [

	ocol addAll: #( 1 2 3 4 ).
	self assert: ocol asArray equals: #(1 2 3 4).
	self assert: mirror asArray equals: #(1 2 3 4).
	ocol add: 77 afterIndex: 0.
	self assert: ocol asArray equals: #(77 1 2 3 4).
	self assert: mirror asArray equals: #(77 1 2 3 4).
	ocol add: 88 afterIndex: 2.
	self assert: mirror asArray equals: #(77 1 88 2 3 4).
	ocol add: 99 afterIndex: ocol size.
	self assert: mirror asArray equals: #(77 1 88 2 3 4 99)
]

{ #category : #'tests - adding' }
ToObservableCollectionMirrorUpdaterTest >> testAddAll [

	| c2 |
	ocol addAll: #(1 2 3 4).
	c2 := ToObservableCollection newFrom: #(5 6 7 8 9).
	ocol addAll: c2.
	self assert: mirror asArray equals: #(1 2 3 4 5 6 7 8 9)
]

{ #category : #'tests - adding' }
ToObservableCollectionMirrorUpdaterTest >> testAddAllFirst [

	| c1 |
	ocol addAll: #( 1 2 3 4 ).
	c1 := ToObservableCollection new
		      addAll: #( 5 6 7 8 9 );
		      yourself.
	ocol addAllFirst: c1.
	self
		assert: mirror asOrderedCollection
		equals: #( 5 6 7 8 9 1 2 3 4 ) asOrderedCollection
]

{ #category : #'tests - adding' }
ToObservableCollectionMirrorUpdaterTest >> testAddAllLast [

	| c2 |
	ocol addAll: #( 1 2 3 4 ).
	c2 := ToObservableCollection new
		      addAll: #( 5 6 7 8 9 );
		      yourself.
	ocol addAllLast: c2.
	self
		assert: mirror asOrderedCollection
		equals: #( 1 2 3 4 5 6 7 8 9 ) asOrderedCollection 
]

{ #category : #'tests - adding' }
ToObservableCollectionMirrorUpdaterTest >> testAddBefore [

	| l i |
	ocol
		     addAll: #( 1 2 3 4 ).

	ocol add: 88 before: 1.


	self
		assert: mirror asOrderedCollection
		equals: #(88 1 2 3 4) asOrderedCollection.

	ocol add: 99 before: 2.

	self
		assert: mirror asOrderedCollection
		equals: #(88 1 99 2 3 4) asOrderedCollection
]

{ #category : #'tests - adding' }
ToObservableCollectionMirrorUpdaterTest >> testAddBeforeAndRemove [

	| initialCollection |
	ocol addAll: #( 1 2 3 4 ).

	initialCollection := ocol copy.

	ocol add: 88 before: 1.

	self
		assert: mirror asOrderedCollection
		equals: #( 88 1 2 3 4 ) asOrderedCollection.

	ocol add: 99 before: 2.
	ocol remove: 99.
	ocol remove: 88.

	self assert: mirror asArray equals: initialCollection asArray
]

{ #category : #'tests - adding' }
ToObservableCollectionMirrorUpdaterTest >> testAddBeforeIndex [

	ocol addAll: #( 1 2 3 4 ).
	ocol add: 88 beforeIndex: 1.
	self
		assert: mirror asOrderedCollection
		equals: #( 88 1 2 3 4 ) asOrderedCollection.

	ocol add: 99 beforeIndex: 3.

	self
		assert: mirror asOrderedCollection
		equals: #( 88 1 99 2 3 4 ) asOrderedCollection
]

{ #category : #'tests - adding' }
ToObservableCollectionMirrorUpdaterTest >> testAddFirst [

	ocol addAll: #( 1 2 3 4 ).

	ocol addFirst: 88.

	self
		assert: mirror asOrderedCollection
		equals: #( 88 1 2 3 4 ) asOrderedCollection.

	ocol addFirst: 99.

	self
		assert: mirror asOrderedCollection
		equals: #( 99 88 1 2 3 4 ) asOrderedCollection
]

{ #category : #'tests - adding' }
ToObservableCollectionMirrorUpdaterTest >> testAddLast [


	ocol
		     addAll: #( 1 2 3 4 ).

	ocol addLast: 88.

	self
		assert: mirror asOrderedCollection
		equals: #(1 2 3 4 88) asOrderedCollection.

	ocol addLast: 99.

	self
		assert: mirror asOrderedCollection
		equals: #(1 2 3 4 88 99) asOrderedCollection
]

{ #category : #'tests - accessing' }
ToObservableCollectionMirrorUpdaterTest >> testAt [
	ocol addAll: #('Jim' 'Mary' 'John' 'Andrew').
	self assert: (mirror at: 1) equals: 'Jim'.
	self assert: (mirror at: 2) equals: 'Mary'
]

{ #category : #'tests - accessing' }
ToObservableCollectionMirrorUpdaterTest >> testAtPut [
	"Allows one to replace an element but not at an off range index"

	ocol addAll:  #(1 2 3 4).
	ocol at: 2 put: 5.

	self assert: mirror asArray equals: #(1 5 3 4).
	self should: [ ocol at: 5 put: 8 ] raise: Error.
	self deny: mirror asArray equals: #(1 5 3 4 8)
]

{ #category : #'tests - adding' }
ToObservableCollectionMirrorUpdaterTest >> testRegisterActionLink [

	ocol add: 88.
	self
		assert: mirror asOrderedCollection
		equals: #( 88 ) asOrderedCollection.
	ocol add: 99.
	self
		assert: mirror asOrderedCollection
		equals: #( 88 99 ) asOrderedCollection
]

{ #category : #'tests - removing' }
ToObservableCollectionMirrorUpdaterTest >> testRemove [

	ocol addAll: #( 2 3 4 6 ).

	ocol remove: 3.
	self assert: mirror asArray equals: #( 2 4 6 )
]

{ #category : #'tests - removing' }
ToObservableCollectionMirrorUpdaterTest >> testRemoveAll [

	ocol addAll: #( 2 3 4 6 ).
	ocol removeAll.
	self assert: mirror size equals: 0.
]

{ #category : #'tests - removing' }
ToObservableCollectionMirrorUpdaterTest >> testRemoveAt [

	ocol addAll: #( 2 3 4 6 ).
	ocol removeAt: 2.

	self assert: mirror asArray equals: #( 2 4 6 ).

]

{ #category : #'tests - removing' }
ToObservableCollectionMirrorUpdaterTest >> testRemoveFirst [


	ocol addAll: #( 2 3 4 6 ).
	ocol removeFirst: 1.
	self assert: mirror asArray equals: #( 3 4 6 ).
	ocol removeFirst: 2.
	self assert: mirror asArray equals: #( 6 )
]

{ #category : #'tests - removing' }
ToObservableCollectionMirrorUpdaterTest >> testRemoveFromTo [

	ocol addAll: #( 2 3 4 6 ).
	ocol removeFrom: 2 to: 2.

	self assert: mirror size equals: 3.

	ocol addAll: (1 to: 100).
	ocol removeFrom: 2 to: 103.
	self assert: mirror size equals: 1.
	self assert: mirror asArray equals: #( 2  )
]

{ #category : #'tests - removing' }
ToObservableCollectionMirrorUpdaterTest >> testRemoveLast [
	"Allows one to remove n element of a collection at the end"

	ocol addAll: #(2 3 4 6).
	ocol removeLast: 1.
	self assert: mirror asArray equals: #(2 3 4).
	ocol removeLast: 2.
	self assert: mirror asArray equals: #(2)
]

{ #category : #'tests - adding' }
ToObservableCollectionMirrorUpdaterTest >> testUpdateAllWith [

	ocol addAll: #( 1 2 3 4 ).

	ocol updateAllWith: #(  ).
	self
		assert: mirror asOrderedCollection
		equals: #(  ) asOrderedCollection.
	ocol updateAllWith: #( 5 6 7 8 9 ).

	self
		assert: mirror asOrderedCollection
		equals: #( 5 6 7 8 9 ) asOrderedCollection
]
