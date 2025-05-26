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
	tree nodeManager childrenGetter: [ :dataItem |
		dataItem = 1
			ifTrue: [ {  } ]
			ifFalse: [ { (dataItem - 1) } ] ].
	tree dataAccessor addAll: (1 to: 5).

	self assert: tree dataAccessor size equals: 5.
	tree dataSource do: [ :each | self assert: each isExpanded not ].

	tree expandAll.
	self assert: tree dataAccessor size equals: 15.
	tree dataSource do: [ :each |
		self assert: (each isExpanded or: each hasLeafDataItem) ].

	tree collapseAll.
	self assert: tree dataAccessor size equals: 5.
	tree dataSource do: [ :each | self assert: each isExpanded not ]
]

{ #category : #tests }
ToTreeDataItemWrapperTest >> testObjectAddedToDataSourceGetsWrapped [

	self assert: tree dataAccessor isEmpty.

	tree dataAccessor add: Collection.

	self
		assert: (tree dataSource at: 1) className
		equals: #ToTreeDataItemWrapper
]

{ #category : #tests }
ToTreeDataItemWrapperTest >> testWrapperHasRightDepth [

	| wrapper |
	tree nodeManager childrenGetter: [ :dataItem | dataItem subclasses asOrderedCollection ].
	self assert: tree dataAccessor isEmpty.
	tree dataAccessor add: Collection.

	wrapper := tree dataSource at: 1.
	self assert: wrapper nodeDepth equals: 0.
	wrapper expand.
	wrapper childWrappersDo: [ :child |
		self assert: child nodeDepth equals: 1 ]
]

{ #category : #tests }
ToTreeDataItemWrapperTest >> testWrappersExpandsAddsChildren [

	| wrapper |
	tree nodeManager childrenGetter: [ :dataItem |
		dataItem = 1
			ifTrue: [ {  } ]
			ifFalse: [ { (dataItem - 1) } ] ].

	self assert: tree dataAccessor isEmpty.
	tree dataAccessor add: 2.

	wrapper := tree dataSource at: 1.
	self assert: tree dataSource size equals: 1.
	self assert: tree dataAccessor size equals: 1.
	self deny: wrapper isExpanded.
	wrapper expand.
	self assert: wrapper isExpanded.
	self assert: tree dataAccessor size equals: 2
]

{ #category : #tests }
ToTreeDataItemWrapperTest >> testWrappersExpandsAddsChildrenAndCollapsesRemovesThem [

	| wrapper |
	tree nodeManager childrenGetter: [ :dataItem |
		dataItem = 1
			ifTrue: [ {  } ]
			ifFalse: [ { (dataItem - 1) } ] ].

	self assert: tree dataAccessor isEmpty.
	tree dataAccessor add: 2.

	wrapper := tree dataSource at: 1.
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
	tree nodeManager childrenGetter: [ :dataItem | dataItem subclasses asOrderedCollection ].
	self assert: tree dataAccessor isEmpty.
	tree dataAccessor add: Collection.

	wrapper := tree dataSource at: 1.
	self deny: wrapper isExpanded.
	wrapper collapse.
	self deny: wrapper isExpanded.
	wrapper expand.
	self assert: wrapper isExpanded.
	wrapper expand.
	self assert: wrapper isExpanded
]
