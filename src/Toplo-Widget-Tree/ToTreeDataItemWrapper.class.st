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
		'cachedChildWrappers',
		'isExpanded'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'private - accessing' }
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

	^ self childrenIntervalFromPosition: self position
]

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> childWrappersDo: aBlock [

	self childrenInterval do: [ :p |
		aBlock value: (treeElement dataSource at: p) ]
]

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> childWrappersFromPosition: aPosition [

	^ Array streamContents: [ :stream |
		  (self childrenIntervalFromPosition: aPosition) do: [ :p |
			  stream nextPut: (treeElement dataSource at: p) ] ]
]

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> childWrappersFromPosition: aPosition reverseDo: aBlock [

	| interval |
	interval := self childrenIntervalFromPosition: aPosition.
	interval last to: interval first by: -1 do: [ :p |
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

	^ self childrenIntervalFromPosition: self position
]

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> childrenIntervalFromPosition: aPosition [

	| first nb |
	first := aPosition.
	nb := 1.
	[
	first + nb <= treeElement dataSource size and: [
		(treeElement dataSource at: first + nb) hasParentWrapper: self ] ]
		whileTrue: [ nb := nb + 1 ].
	
	^ first + 1 to: first + nb - 1
]

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> collapse [

	| childrenInterval pos |
	self isExpanded ifFalse: [ ^ self ].
	isExpanded := false.
	pos := self position.
	self putCurrentChildWrappersInCacheFromPosition: pos.
	childrenInterval := self childrenIntervalFromPosition: pos.
	treeElement dataAccessor
		removeFrom: childrenInterval first
		to: childrenInterval last.
	self updateTreeNodeAtPosition: pos
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
	self isExpanded ifTrue: [ ^ nil ].
	isExpanded := true.
	children := self dataItemChildren.
	pos := self position.

	(self canUseCachedWrappersWithCurrentChildren: children)
		ifTrue: [
		treeElement dataSource addAll: cachedChildWrappers afterIndex: pos ]
		ifFalse: [
				treeElement dataAccessor
					useParentWrapper: self
					while: [
					treeElement dataAccessor addAll: children afterIndex: pos ] ].

	self updateTreeNodeAtPosition: pos.
	^ pos
]

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> expandAll [

	| pos |
	self collapse.
	pos := self expand ifNil: [ self position ].
	self
		childWrappersFromPosition: pos
		reverseDo: [ :each | each expandAll ]
]

{ #category : #testing }
ToTreeDataItemWrapper >> hasChildWrappers [

	^ cachedChildWrappers notNil and: [ cachedChildWrappers notEmpty ]
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

	^ isExpanded ifNil: [ isExpanded := false ]
]

{ #category : #testing }
ToTreeDataItemWrapper >> isExpanded: aBoolean [

	isExpanded := aBoolean
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

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> putCurrentChildWrappersInCacheFromPosition: aPosition [

	cachedChildWrappers := self childWrappersFromPosition: aPosition.
	cachedChildWrappers do: [ :w | w putInCache ]
]

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> putInCache [

	isExpanded := false
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

{ #category : #'private - accessing' }
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
