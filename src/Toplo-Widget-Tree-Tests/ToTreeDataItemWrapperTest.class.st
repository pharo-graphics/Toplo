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
	tree sample: 1.
	
]

{ #category : #'expanding-collapsing tests' }
ToTreeDataItemWrapperTest >> testCollapseEventDispatched [

	| wrapper dispatchedEvent size dispatchCount |
	tree nodeManager childrenGetter: [ :dataItem |
			dataItem = 1
				ifTrue: [ {  } ]
				ifFalse: [ { (dataItem - 1) } ] ].
	tree dataAccessor addAll: (1 to: 5).
	size := tree dataSource size.
	dispatchCount := 0.
	tree
		addEventHandlerOn: ToTreeDataItemWrapperCollapsedEvent
		do: [ :evt |
				dispatchCount := dispatchCount + 1.
				dispatchedEvent := evt ].
	wrapper := tree dataSource at: 5.
	dispatchedEvent := nil.
	dispatchCount := 0.
	wrapper expandAll.
	self assert: tree dataSource size equals: size + 4.
	wrapper collapse.
	self assert: dispatchedEvent notNil.
	self assert: dispatchedEvent wrapper equals: wrapper.
	self assert: dispatchCount equals: 1
]

{ #category : #'expanding-collapsing tests' }
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

{ #category : #'expanding-collapsing tests' }
ToTreeDataItemWrapperTest >> testExpandAllEventDispatched [

	| wrapper dispatchedEvent size dispatchCount |
	tree nodeManager childrenGetter: [ :dataItem |
			dataItem = 1
				ifTrue: [ {  } ]
				ifFalse: [ { (dataItem - 1) } ] ].
	tree dataAccessor addAll: (1 to: 5).
	size := tree dataSource size.
	dispatchCount := 0.
	tree
		addEventHandlerOn: ToTreeDataItemWrapperExpandedEvent
		do: [ :evt |
				dispatchCount := dispatchCount + 1.
				dispatchedEvent := evt ].
	wrapper := tree dataSource at: 5.
	dispatchedEvent := nil.
	dispatchCount := 0.
	wrapper expandAll.
	self assert: dispatchedEvent notNil.
	self assert: dispatchedEvent deeply.
	self assert: dispatchedEvent wrapper equals: wrapper.
	self assert: dispatchCount equals: 1.
	self assert: tree dataSource size equals: size + 4
]

{ #category : #'expanding-collapsing tests' }
ToTreeDataItemWrapperTest >> testExpandEventDispatched [

	| wrapper dispatchedEvent size |
	tree nodeManager childrenGetter: [ :dataItem |
			dataItem = 1
				ifTrue: [ {  } ]
				ifFalse: [ { (dataItem - 1) } ] ].
	tree dataAccessor addAll: (1 to: 5).
	size := tree dataSource size.
	tree
		addEventHandlerOn: ToTreeDataItemWrapperExpandedEvent
		do: [ :evt | dispatchedEvent := evt ].
	wrapper := tree dataSource at: 5.
	dispatchedEvent := nil.
	wrapper expand.
	self assert: dispatchedEvent notNil.
	self deny: dispatchedEvent deeply.
	self assert: dispatchedEvent wrapper equals: wrapper.
	self assert: tree dataSource size equals: size + 1
]

{ #category : #tests }
ToTreeDataItemWrapperTest >> testExpandRoots [

	self assert: tree dataAccessor isEmpty.
	tree nodeManager childrenGetter: [ :dataItem |
		dataItem = 1
			ifTrue: [ {  } ]
			ifFalse: [ { (dataItem - 1) } ] ].
	tree dataAccessor addAll: (1 to: 5).

	self assert: tree dataAccessor size equals: 5.
	tree dataSource do: [ :each | self assert: each isExpanded not ].

	tree expandRoots.
	self assert: tree dataAccessor size equals: 9.
	tree dataSource do: [ :each | self assert: (each isExpanded or: [ each isRoot not ]) ]
]

{ #category : #'expanding-collapsing tests' }
ToTreeDataItemWrapperTest >> testObjectAddedToDataSourceGetsWrapped [

	self assert: tree dataAccessor isEmpty.

	tree dataAccessor add: Collection.

	self
		assert: (tree dataSource at: 1) class
		equals: ToTreeDataItemWrapper.
	self
		assert: (tree dataAccessor at: 1)
		equals: Collection.
]

{ #category : #'expanding-collapsing tests' }
ToTreeDataItemWrapperTest >> testWrapperExpandAddChildrenAndCollapseRemovesThem [

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

{ #category : #'expanding-collapsing tests' }
ToTreeDataItemWrapperTest >> testWrapperExpandAndCollapse [

	| wrapper |
	tree nodeManager childrenGetter: [ :dataItem | dataItem subclasses ].
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

{ #category : #'expanding-collapsing tests' }
ToTreeDataItemWrapperTest >> testWrapperExpandsAddsChildren [

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

{ #category : #'expanding-collapsing tests' }
ToTreeDataItemWrapperTest >> testWrapperHasRightDepth [

	| wrapper |
	tree nodeManager childrenGetter: [ :dataItem | dataItem subclasses ].
	self assert: tree dataAccessor isEmpty.
	tree dataAccessor add: Collection.

	wrapper := tree dataSource at: 1.
	self assert: wrapper nodeDepth equals: 0.
	wrapper expand.
	wrapper childWrappersDo: [ :child |
		self assert: child nodeDepth equals: 1 ]
]
