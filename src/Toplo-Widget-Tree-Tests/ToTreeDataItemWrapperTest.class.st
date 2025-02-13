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

	| wrapper |
	self assert: tree dataAccessor isEmpty.
	tree dataWrapperClass: ToTreeDataItemIntegerHalfWrapper.
	tree dataAccessor addAll: (1 to: 5).

	self assert: tree dataAccessor size equals: 5.
	tree dataAccessor do: [ :each | self assert: each isCollapsed ].

	tree expandAll.
	self assert: tree dataAccessor size equals: 11.
	tree dataAccessor do: [ :each |
		self assert: (each isCollapsed not or: each isLeaf) ].

	tree collapseAll.
	self assert: tree dataAccessor size equals: 5.
	tree dataAccessor do: [ :each | self assert: each isCollapsed ]
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
	tree dataWrapperClass: ToTreeDataItemIntegerHalfWrapper .
	tree dataAccessor add: 2.

	wrapper := tree dataAccessor at: 1.
	self assert: tree dataAccessor size equals: 1.
	self assert: wrapper isCollapsed.
	wrapper expand.
	self deny: wrapper isCollapsed.
	self assert: tree dataAccessor size equals: 2
]

{ #category : #tests }
ToTreeDataItemWrapperTest >> testWrappersExpandsAddsChildrenAndCollapsesRemovesThem [

	| wrapper |
	self assert: tree dataAccessor isEmpty.
	tree dataWrapperClass: ToTreeDataItemIntegerHalfWrapper.
	tree dataAccessor add: 2.

	wrapper := tree dataAccessor at: 1.
	self assert: tree dataAccessor size equals: 1.
	self assert: wrapper isCollapsed.
	wrapper expand.
	self deny: wrapper isCollapsed.
	self assert: tree dataAccessor size equals: 2.
	wrapper collapse.
	self assert: tree dataAccessor size equals: 1.
	self assert: wrapper isCollapsed
]

{ #category : #tests }
ToTreeDataItemWrapperTest >> testWrappersExpandsAndCollapses [

	| wrapper |
	self assert: tree dataAccessor isEmpty.
	tree dataAccessor add: Collection.

	wrapper := (tree dataAccessor at: 1).
	self assert: wrapper isCollapsed.
	wrapper collapse.
	self assert: wrapper isCollapsed.
	wrapper expand.
	self deny: wrapper isCollapsed.
	wrapper expand.
	self deny: wrapper isCollapsed.
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
	self assert: wrapper nodeDepth equals: 1.

	wrapper determineAndWrapChildren.
	wrapper children do: [ :child |
		self assert: child nodeDepth equals: 2 ]
]
