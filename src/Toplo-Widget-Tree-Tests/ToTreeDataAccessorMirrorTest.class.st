"
A ToCollectionMirrorTest is a test class for testing the behavior of ToCollectionMirror
"
Class {
	#name : #ToTreeDataAccessorMirrorTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Tree-Tests-Core'
}

{ #category : #tests }
ToTreeDataAccessorMirrorTest >> testAddAll [

	| tree l m |
	tree := ToTreeElement new.
	l := tree dataAccessor.
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
ToTreeDataAccessorMirrorTest >> testRegisterActionLink [

	| tree l m |
	tree := ToTreeElement new.
	l := tree dataAccessor.
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
ToTreeDataAccessorMirrorTest >> testRemove [

	| tree l m |
	tree := ToTreeElement new.
	l := tree dataAccessor.
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
ToTreeDataAccessorMirrorTest >> testRemoveAll [

	| tree l m |
	tree := ToTreeElement new.
	l := tree dataAccessor.
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
ToTreeDataAccessorMirrorTest >> testRemoveFromTo [

	| tree l m |
	tree := ToTreeElement new.
	l := tree dataAccessor.
	m := l newMirror.

	l addAll: #( 2 3 4 6 ).
	l removeFrom: 2 to: 2.

	self assert: m size equals: 3.

	l addAll: (1 to: 100).
	l removeFrom: 2 to: 103.
	self assert: m size equals: 1.
	self assert: m asArray equals: #( 2  )
]
