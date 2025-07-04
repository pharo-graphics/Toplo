"
A ToCollectionMirrorTest is a test class for testing the behavior of ToCollectionMirror
"
Class {
	#name : #ToCollectionMirrorTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Collection'
}

{ #category : #tests }
ToCollectionMirrorTest >> testAdd [

	| l m |
	l := ToObservableCollection new.
	m := l newMirror.
	l add: 88.
	self
		assert: m asOrderedCollection
		equals: #( 88 ) asOrderedCollection.
	l add: 99.
	self
		assert: m asOrderedCollection
		equals: #( 88 99 ) asOrderedCollection
]

{ #category : #tests }
ToCollectionMirrorTest >> testAddAll [

	| l m |
	l := ToObservableCollection new.
	m := l newMirror.
	l addAll: #(1 2 3 4).
	self
		assert: l asArray
		equals: #(1 2 3 4).
	self
		assert: m asArray
		equals: #(1 2 3 4)
]

{ #category : #tests }
ToCollectionMirrorTest >> testRemove [

	| l m |
	l := ToObservableCollection new.
	m := l newMirror.
	l addAll: #(1 2 3 4).
	l remove: 2.
	self
		assert: l asArray
		equals: #(1 3 4).
	self
		assert: m asArray
		equals: #(1 3 4).

]

{ #category : #tests }
ToCollectionMirrorTest >> testRemoveAll [

	| l m |
	l := ToObservableCollection new.
	m := l newMirror.
	l addAll: #(1 2 3 4).
	l removeAll.
	self
		assert: l asArray
		equals: #( ).
	self
		assert: m asArray
		equals: #( ).

]

{ #category : #tests }
ToCollectionMirrorTest >> testRemoveFromTo [

	| l m |
	l := ToObservableCollection new.
	m := l newMirror.

	l addAll: #( 2 3 4 6 ).
	l removeFrom: 2 to: 2.

	self assert: m size equals: 3.

	l addAll: (1 to: 100).
	l removeFrom: 2 to: 103.
	self assert: m size equals: 1.
	self assert: m asArray equals: #( 2  )
]
