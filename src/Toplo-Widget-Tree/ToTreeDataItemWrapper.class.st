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
		'expanded',
		'treeElement',
		'dataItem',
		'children'
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
	expanded ifFalse: [ ^ self ].
	childrenInterval := self childrenInterval.
	treeElement dataAccessor
		removeFrom: childrenInterval first
		to: childrenInterval last.
	expanded := false.
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

	^ children ifNil: [
		  children := treeElement nodeManager childrenFromDataItem:
			              self dataItem ]
]

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> expand [

	| pos |
	(self isLeaf or: expanded) ifTrue: [ ^ self ].
	expanded := true.
	pos := self position.
	treeElement dataAccessor useParentWrapper: self while: [
		self dataItemChildren doWithIndex: [ :each :idx |
			treeElement dataAccessor add: each afterIndex: pos + idx - 1 ] ].
	treeElement dataSource notifyDataItemChangeIndex: pos
]

{ #category : #'expanding-collapsing' }
ToTreeDataItemWrapper >> expandAll [

	self expand.
	self childWrappers reverseDo: [ :each | each expandAll ].

]

{ #category : #testing }
ToTreeDataItemWrapper >> hasParentWrapper: aDataItemWrapper [

	parentWrapper = aDataItemWrapper ifTrue: [ ^ true ].
	^ parentWrapper
		  ifNil: [ aDataItemWrapper isNil ]
		  ifNotNil: [ parentWrapper hasParentWrapper: aDataItemWrapper ]
]

{ #category : #initialization }
ToTreeDataItemWrapper >> initialize [

	super initialize.
	expanded := false
]

{ #category : #testing }
ToTreeDataItemWrapper >> isExpanded [ 

	^ expanded 
]

{ #category : #testing }
ToTreeDataItemWrapper >> isLeaf [

	^ self dataItemChildren isEmpty
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
