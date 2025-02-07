"
I am a Tree Element,

I display data in a tree structure by holding Tree Nodes.

My model relies on a DataSource holding the data displayed and a TreeNodeManager dealing with the TreeNodes
"
Class {
	#name : #ToTreeElement,
	#superclass : #ToListElement,
	#instVars : [
		'childSelector'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'as yet unclassified' }
ToTreeElement class >> exampleIntegerHalf [

	| l |
	l := self new.
	l childSelector: ToTreeIntegerHalfChildSelector.
	l dataAccessor addAll: (1 to: 10).


	l openInSpace
]

{ #category : #'as yet unclassified' }
ToTreeElement class >> exampleProtoObjectSubclasses [
	"This example shows classes as a list but using TreeNodes, tree logic is not implemented at this time of writing the example"

	| l |
	l := self new.
	l dataAccessor add: ProtoObject.

	l openInSpace
]

{ #category : #'as yet unclassified' }
ToTreeElement class >> exampleWithFewClasses [
	"This example allows us to expand and collapse classes to see their subclasses, however the collapsing is not done recursively on the children, causing issues if we expand classes to at least depth 3 and collapse depth 1"

	| l |
	l := self new.
	l dataAccessor add: BlElement.
	l dataAccessor add: Collection.
	l dataAccessor add: String.

	l openInSpace
]

{ #category : #accessing }
ToTreeElement >> childSelector [

	^ childSelector ifNil: [ self defaultTreeChildSelector ]
]

{ #category : #accessing }
ToTreeElement >> childSelector: aToTreeChildSelector [

	childSelector := aToTreeChildSelector.
	dataSource childSelector: aToTreeChildSelector 
]

{ #category : #initialization }
ToTreeElement >> defaultDataSource [

	^ ToTreeInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToTreeElement >> defaultNodeManagerClass [

	^ ToGenericTreeNodeManager  
]

{ #category : #initialization }
ToTreeElement >> defaultTreeChildSelector [

	^ ToTreeClassChildSelector
]

{ #category : #initialization }
ToTreeElement >> initialize [

	super initialize.
	nodeManager
		treeElement: self

	"maybe add a default Child Selector ?"
]

{ #category : #initialization }
ToTreeElement >> initializeDataSource [

	super initializeDataSource.
	self dataSource childSelector: self childSelector 
]
