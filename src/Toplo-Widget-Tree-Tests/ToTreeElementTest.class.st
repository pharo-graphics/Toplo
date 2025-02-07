Class {
	#name : #ToTreeElementTest,
	#superclass : #TestCase,
	#instVars : [
		'tree'
	],
	#category : #'Toplo-Widget-Tree-Tests-Core'
}

{ #category : #running }
ToTreeElementTest >> setUp [
	super setUp.
	tree := ToTreeElement new.
]

{ #category : #tests }
ToTreeElementTest >> testTreeElementChildSelectorChangesAlsoInDataSource [

	self
		assert: tree childSelector className
		equals: #ToTreeClassChildSelector.
	self
		assert: tree dataAccessor childSelector className
		equals: #ToTreeClassChildSelector.

	tree childSelector: ToTreeIntegerHalfChildSelector new.

	self
		assert: tree childSelector className
		equals: #ToTreeIntegerHalfChildSelector.
	self
		assert: tree dataAccessor childSelector className
		equals: #ToTreeIntegerHalfChildSelector
]

{ #category : #tests }
ToTreeElementTest >> testTreeElementInitializesDataSourceAndNodeManager [

	self assert:
		(tree dataAccessor class inheritsFrom:
			 ToInfiniteCollectionDataSource).

	self assert:
		(tree nodeManager class inheritsFrom: ToGenericListNodeManager)
]
