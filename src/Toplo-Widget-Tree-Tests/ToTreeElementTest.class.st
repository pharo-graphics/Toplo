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
		assert: tree dataWrapperClass name
		equals: #ToTreeDataItemWrapper.
	self
		assert: tree dataAccessor dataWrapperClass name
		equals: #ToTreeDataItemWrapper.

	tree dataWrapperClass: ToTreeDataItemRandomIntegersWrapper new.

	self
		assert: tree dataWrapperClass className
		equals: #ToTreeDataItemRandomIntegersWrapper.
	self
		assert: tree dataAccessor dataWrapperClass className
		equals: #ToTreeDataItemRandomIntegersWrapper
]

{ #category : #tests }
ToTreeElementTest >> testTreeElementInitializesDataSourceAndNodeManager [

	self assert:
		(tree dataAccessor class inheritsFrom:
			 ToInfiniteCollectionDataSource).

	self assert:
		(tree nodeManager class inheritsFrom: ToGenericListNodeManager)
]
