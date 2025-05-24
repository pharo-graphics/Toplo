"
I am a ToTreeDataSourceWrapper 

My purpose is to wrap an Object (called dataItem) when one is added to a ToTreeDataSource.

I wrap this item and keep references to :
 - this object
 - its children, as they are defined by the dataSource childSelector
 - the number of children this object has
 - the state of the node linked to this object (collapsed or expanded)
"
Class {
	#name : #ToTreeDataItemWrapper,
	#superclass : #Object,
	#instVars : [
		'parentWrapper',
		'treeElement',
		'dataItem'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

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

	self childrenInterval reversed do: [ :p |
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
	treeElement dataSource notifyDataItemChangeIndex: childrenInterval first - 1.
	
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

	| pos |
	(self hasLeafDataItem or: self isExpanded) ifTrue: [ ^ self ].
	pos := self position.
	treeElement dataAccessor useParentWrapper: self while: [
		treeElement dataAccessor
			addAll: self dataItemChildren
			afterIndex: pos ].
	treeElement dataSource notifyDataItemChangeIndex: pos
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

{ #category : #accessing }
ToTreeDataItemWrapper >> wrapped: aDataItem [

	self dataItem: aDataItem
]
