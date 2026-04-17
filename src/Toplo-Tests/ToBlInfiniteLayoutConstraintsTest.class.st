Class {
	#name : #ToBlInfiniteLayoutConstraintsTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core'
}

{ #category : #tests }
ToBlInfiniteLayoutConstraintsTest >> testDecorationInsetsDefaultsToEmptyInsets [

	self
		assert: BlInfiniteLayoutConstraints new decorationInsets
		equals: BlInsets empty
]

{ #category : #tests }
ToBlInfiniteLayoutConstraintsTest >> testLinearLayoutReadsDecorationInsetsBeforeComputation [

	| layout element |
	layout := BlInfiniteLinearLayout new.
	element := BlElement new.

	self assert: (layout topDecorationHeight: element) equals: 0
]
