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
		'dataItem',
		'children',
		'parentWrapper',
		'expanded',
		'treeElement'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'private - accessing' }
ToTreeDataItemWrapper >> childWrappersInterval [

	| idx first last |
	self children ifEmpty: [ ^ 1 to: 0 ].
	idx := self position.

	[
	idx <= self dataSource size and: [
			(self dataSource at: idx) parentWrapper = self ] ] whileFalse: [
		idx := idx + 1 ].
	first := idx.
	[
	idx <= self dataSource size and: [
		(self dataSource at: idx) parentWrapper notNil and: [
			(self dataSource at: idx) hasParentWrapper: self ] ] ] whileTrue: [
		idx := idx + 1 ].
	last := idx - 1.
	^ first to: last
]

{ #category : #accessing }
ToTreeDataItemWrapper >> children [

	^ children ifNil: [ children := self computedChildren collect: [ :each |
		                   self class new
			                   treeElement: treeElement;
			                   dataItem: each;
			                   parentWrapper: self ]].

]

{ #category : #accessing }
ToTreeDataItemWrapper >> collapse [

	| childrenInterval |
	expanded ifFalse: [ ^ self ].

	childrenInterval := self childWrappersInterval.
	childrenInterval do: [ :idx |
		(self dataSource at: idx) privateExpanded: false ].
	self dataSource
		removeFrom: childrenInterval first
		to: childrenInterval last.

	expanded := false
]

{ #category : #accessing }
ToTreeDataItemWrapper >> computedChildren [

	^ self treeElement nodeManager childrenFromDataItem: dataItem
]

{ #category : #accessing }
ToTreeDataItemWrapper >> dataItem [ 

	^ dataItem 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> dataItem: anObject [ 

	dataItem := anObject 
]

{ #category : #accessing }
ToTreeDataItemWrapper >> dataSource [ 

	^ self treeElement dataSource
]

{ #category : #accessing }
ToTreeDataItemWrapper >> expand [

	| pos |
	(self isLeaf or: expanded) ifTrue: [ ^ self ].
	expanded := true.

	pos := self position.
	self children withIndexDo: [ :wrapper :idx |
		self dataSource add: wrapper afterIndex: pos + idx - 1 ]
]

{ #category : #accessing }
ToTreeDataItemWrapper >> expandAll [

	self expand.
	self children do: [ :each | each expandAll ]
]

{ #category : #testing }
ToTreeDataItemWrapper >> hasParentWrapper: aWrapper [

	parentWrapper ifNil: [ ^ false ].
	parentWrapper = aWrapper ifTrue: [ ^ true ].
	^ parentWrapper hasParentWrapper: aWrapper
]

{ #category : #initialization }
ToTreeDataItemWrapper >> initialize [

	super initialize.
	expanded := false
]

{ #category : #accessing }
ToTreeDataItemWrapper >> isExpanded [ 

	^ expanded 
]

{ #category : #testing }
ToTreeDataItemWrapper >> isLeaf [

	^ self children isEmpty
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

	^ self dataSource indexOf: self
]

{ #category : #testing }
ToTreeDataItemWrapper >> privateExpanded: aBoolean [

	expanded := aBoolean 
]

{ #category : #operations }
ToTreeDataItemWrapper >> toggle [

	self isExpanded
		ifTrue: [ self collapse ]
		ifFalse: [ self expand ].

	self flag:
		'Should use notifyItemsChanged: but we should find a way to not compute the position but keep it in the wrapper (pay attention, it have to be recomputed when extending/collapsing). Have a look at  morphic fast table to see how the do that'.
	self dataSource notifyItemsChanged: (self position to: self position)
	"dataSource notifyChanged"
]

{ #category : #accessing }
ToTreeDataItemWrapper >> treeElement [

	^ treeElement
]

{ #category : #accessing }
ToTreeDataItemWrapper >> treeElement: aTreeElement [

	treeElement := aTreeElement 
]
