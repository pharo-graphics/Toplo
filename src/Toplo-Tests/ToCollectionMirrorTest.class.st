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
