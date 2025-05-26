"
I am a ToTreeDataSourceWrapper 

My purpose is to wrap an Object (called dataItem) when it is added to a ToTreeDataSource.
"
Class {
	#name : #ToTreeDataItemWrapper,
	#superclass : #Object,
	#instVars : [
		'parentWrapper',
		'treeElement',
		'dataItem',
		'cachedChildWrappers'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> canUseCachedWrappersWithCurrentChildren: aDataItemCollection [

	" There is no magic involved; caching does not allow for significant time optimisation here.
	However, cached wrappers allow extra information to be stored that can be useful 
	(for example, one can keep track of children's selections). "

	| idx |
	cachedChildWrappers ifNil: [ ^ false ].
	" don't use #= to compare content of children with cachedChildWrappers because 
		the collection classes may differ and #asArray sends may be time consuming "
	aDataItemCollection size = cachedChildWrappers size ifFalse: [
		^ false ].
	idx := 1.
	[
	idx <= cachedChildWrappers size and: [
		(cachedChildWrappers at: idx) dataItem
		= (aDataItemCollection at: idx) ] ] whileTrue: [ idx := idx + 1 ].
	^ idx > cachedChildWrappers size
]

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> childWrappers [

	^ Array streamContents: [ :stream |
		  self childrenInterval do: [ :p |
			  stream nextPut: (treeElement dataSource at: p) ] ]
]

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> childWrappersDo: aBlock [

	self childrenInterval do: [ :p |
		aBlock value: (treeElement dataSource at: p) ]
]

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> childWrappersReverseDo: aBlock [

	| interval |
	interval := self childrenInterval.
	interval last to: interval first by: -1 do: [ :p |
	    aBlock value: (treeElement dataSource at: p) ]
]

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> childrenInterval [

	| first nb |
	first := self position.
	nb := 1.
	[
	first + nb <= treeElement dataSource size and: [
		(treeElement dataSource at: first + nb) hasParentWrapper: self ] ]
		whileTrue: [ nb := nb + 1 ].
	
	^ first + 1 to: first + nb - 1
]

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> collapse [

	| childrenInterval |
	self isExpanded ifFalse: [ ^ self ].
	childrenInterval := self childrenInterval.
	treeElement dataAccessor
		removeFrom: childrenInterval first
		to: childrenInterval last.
	self updateTreeNodeAtPosition: childrenInterval first - 1
]

{ #category : #accessing }
ToTreeDataItemWrapper >> dataItem [ 

	^ dataItem 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> dataItem: aDataItem [ 

	dataItem := aDataItem 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> dataItemChildren [

	^ treeElement nodeManager childrenFromDataItem: self unwrapped
]

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> expand [

	| pos children |
	(self hasLeafDataItem or: self isExpanded) ifTrue: [ ^ self ].
	children := self dataItemChildren.
	pos := self position.

	(self canUseCachedWrappersWithCurrentChildren: children)
		ifTrue: [
		treeElement dataSource addAll: cachedChildWrappers afterIndex: pos ]
		ifFalse: [
			cachedChildWrappers := nil.
			treeElement dataAccessor
				useParentWrapper: self
				while: [
				treeElement dataAccessor addAll: children afterIndex: pos ].
			cachedChildWrappers := self childWrappers ].

	self updateTreeNodeAtPosition: pos
]

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> expandAll [

	self collapse.
	self expand.
	self childWrappersReverseDo: [ :each | each expandAll ].

]

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> hasChildren [

	| first |
	first := self position.
	(first + 1 <= treeElement dataSource size and: [
		 (treeElement dataSource at: first + 1) hasParentWrapper: self ])
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #testing }
ToTreeDataItemWrapper >> hasLeafDataItem [

	^ self dataItemChildren isEmpty
]

{ #category : #testing }
ToTreeDataItemWrapper >> hasParentWrapper: aDataItemWrapper [

	parentWrapper = aDataItemWrapper ifTrue: [ ^ true ].
	^ parentWrapper
		  ifNil: [ aDataItemWrapper isNil ]
		  ifNotNil: [ parentWrapper hasParentWrapper: aDataItemWrapper ]
]

{ #category : #testing }
ToTreeDataItemWrapper >> isExpanded [ 

	^ self hasChildren 
]

{ #category : #testing }
ToTreeDataItemWrapper >> isLeaf [

	self
		deprecated: 'Use #hasLeafDataItem instead'
		transformWith: '`@rcvr isLeaf' -> '`@rcvr hasLeafDataItem'.
	^ self hasLeafDataItem
]

{ #category : #testing }
ToTreeDataItemWrapper >> isRoot [

	^ parentWrapper isNil
]

{ #category : #accessing }
ToTreeDataItemWrapper >> nodeDepth [

	^ parentWrapper
		  ifNil: [ 0 ]
		  ifNotNil: [ parentWrapper nodeDepth + 1 ]
]

{ #category : #accessing }
ToTreeDataItemWrapper >> parentWrapper [ 

	^ parentWrapper 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> parentWrapper: aDataItemWrapper [ 

	parentWrapper := aDataItemWrapper 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> position [ 

	^ treeElement dataSource indexOf: self 
]

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> toggle [

	self isExpanded
		ifTrue: [ self collapse ]
		ifFalse: [ self expand ]
]

{ #category : #accessing }
ToTreeDataItemWrapper >> treeElement: aTreeElement [

	treeElement := aTreeElement 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> unwrapped [ 

	^ self dataItem
]

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> updateTreeNodeAtPosition: aPositionInDataSource [

	(treeElement nodesDetect: [ :node | node holder dataItem = self ])
		ifNotNil: [ :node |
			node requestNewSkin.
			treeElement posponeAction: [
				node holder notifySelectedWithOption: treeElement selectionOption ] ]
]

{ #category : #accessing }
ToTreeDataItemWrapper >> wrapped: aDataItem [

	self dataItem: aDataItem
]
