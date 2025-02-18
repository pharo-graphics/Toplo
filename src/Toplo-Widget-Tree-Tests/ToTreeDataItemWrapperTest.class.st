Class {
	#name : #ToTreeDataItemWrapperTest,
	#superclass : #TestCase,
	#instVars : [
		'tree'
	],
	#category : #'Toplo-Widget-Tree-Tests-Wrappers'
}

{ #category : #running }
ToTreeDataItemWrapperTest >> setUp [
	super setUp.
		tree := ToTreeElement new.
]

{ #category : #tests }
ToTreeDataItemWrapperTest >> testExpandAllAndCollapseAll [

	self assert: tree dataAccessor isEmpty.
	tree dataWrapperClass: ToTreeDataItemPreviousIntegerWrapper.
	tree dataAccessor addAll: (1 to: 5).

	self assert: tree dataAccessor size equals: 5.
	tree dataAccessor do: [ :each | self assert: each isExpanded not ].

	tree expandAll.
	self assert: tree dataAccessor size equals: 15.
	tree dataAccessor do: [ :each |
		self assert: (each isExpanded or: each isLeaf) ].

	tree collapseAll.
	self assert: tree dataAccessor size equals: 5.
	tree dataAccessor do: [ :each | self assert: each isExpanded not ]
]

{ #category : #tests }
ToTreeDataItemWrapperTest >> testObjectAddedToDataSourceGetsWrapped [

	self assert: tree dataAccessor isEmpty.

	tree dataAccessor add: Collection.

	self
		assert: (tree dataAccessor at: 1) className
		equals: #ToTreeDataItemWrapper
]

{ #category : #tests }
ToTreeDataItemWrapperTest >> testWrappersExpandsAddsChildren [

	| wrapper |
	self assert: tree dataAccessor isEmpty.
	tree dataWrapperClass: ToTreeDataItemPreviousIntegerWrapper.
	tree dataAccessor add: 2.

	wrapper := tree dataAccessor at: 1.
	self assert: tree dataAccessor size equals: 1.
	self deny: wrapper isExpanded.
	wrapper expand.
	self assert: wrapper isExpanded.
	self assert: tree dataAccessor size equals: 2
]

{ #category : #tests }
ToTreeDataItemWrapperTest >> testWrappersExpandsAddsChildrenAndCollapsesRemovesThem [

	| wrapper |
	self assert: tree dataAccessor isEmpty.
	tree dataWrapperClass: ToTreeDataItemPreviousIntegerWrapper.
	tree dataAccessor add: 2.

	wrapper := tree dataAccessor at: 1.
	self assert: tree dataAccessor size equals: 1.
	self deny: wrapper isExpanded.
	wrapper expand.
	self assert: wrapper isExpanded.
	self assert: tree dataAccessor size equals: 2.
	wrapper collapse.
	self assert: tree dataAccessor size equals: 1.
	self deny: wrapper isExpanded
]

{ #category : #tests }
ToTreeDataItemWrapperTest >> testWrappersExpandsAndCollapses [

	| wrapper |
	self assert: tree dataAccessor isEmpty.
	tree dataWrapperClass: ToTreeDataItemClassWrapper.
	tree dataAccessor add: Collection.

	wrapper := tree dataAccessor at: 1.
	self deny: wrapper isExpanded.
	wrapper collapse.
	self deny: wrapper isExpanded.
	wrapper expand.
	self assert: wrapper isExpanded.
	wrapper expand.
	self assert: wrapper isExpanded
]

{ #category : #tests }
ToTreeDataItemWrapperTest >> testWrappersHasRightChildrenWrappers [

	self assert: tree dataAccessor isEmpty.
	tree dataWrapperClass: ToTreeDataItemClassWrapper.
	tree dataAccessor add: Collection.

	(tree dataAccessor at: 1) children
		with: Collection subclasses
		do: [ :wrapper :subclass |
			self assert: wrapper className equals: #ToTreeDataItemClassWrapper.
			self assert: wrapper dataItem equals: subclass ]
]

{ #category : #tests }
ToTreeDataItemWrapperTest >> testWrappersHasRightDataItem [

	self assert: tree dataAccessor isEmpty.
	tree dataAccessor add: Collection.

	self
		assert: (tree dataAccessor at: 1) dataItem
		equals: Collection 
]

{ #category : #tests }
ToTreeDataItemWrapperTest >> testWrappersHasRightDepth [

	| wrapper |
	self assert: tree dataAccessor isEmpty.
	tree dataWrapperClass: ToTreeDataItemClassWrapper.
	tree dataAccessor add: Collection.

	wrapper := tree dataAccessor at: 1.
	self assert: wrapper nodeDepth equals: 0.

	wrapper children do: [ :child |
		self assert: child nodeDepth equals: 1 ]
]
