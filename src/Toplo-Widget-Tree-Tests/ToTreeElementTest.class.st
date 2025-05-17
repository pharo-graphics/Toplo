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
	tree := ToAbstractTreeElement new.
]

{ #category : #tests }
ToTreeElementTest >> testTreeElementDataAccessorIsDataSourceWrapper [

	self
		assert: tree dataAccessor className
		equals: #ToTreeDataSourceWrapper.

]

{ #category : #tests }
ToTreeElementTest >> testTreeElementDataItemWrapperChangesCorrectly [

	self
		assert: tree dataWrapperClass name
		equals: #ToTreeDataItemWrapper.

	tree dataWrapperClass: ToTreeDataItemPreviousIntegerWrapper new.

	self
		assert: tree dataWrapperClass className
		equals: #ToTreeDataItemPreviousIntegerWrapper.
]

{ #category : #tests }
ToTreeElementTest >> testTreeElementInitializesDataSourceAndNodeManager [

	self
		assert: tree dataSource className
		equals: #ToInfiniteCollectionDataSource.

	self assert: tree nodeManager className
	equals: #ToGenericTreeNodeManager 
]
