"
I am a Tree Element,

I display data in a tree structure by holding Tree Nodes
"
Class {
	#name : #ToTreeElement,
	#superclass : #ToListElement,
	#category : #'Toplo-Widget-Tree'
}

{ #category : #'as yet unclassified' }
ToTreeElement class >> exampleClassNames [

	"This example shows classes as a list but using TreeNodes, tree logic is not implemented at this time of writing the example"
	
	| l |
	l := self new.
	l dataAccessor addAll:
		(Smalltalk globals allClasses collect: [ :cls | cls name ]).

	l openInSpace
]

{ #category : #'as yet unclassified' }
ToTreeElement class >> exampleExpandCollapse [
	"This example allows us to expand and collapse classes to see their subclasses, however the collapsing is not done recursively on the children, causing issues if we expand classes to at least depth 3 and collapse depth 1"

	| l |
	l := self new.
	l dataAccessor add: BlElement.
	l dataAccessor add: Collection.
	l dataAccessor add: String.

	l openInSpace
]

{ #category : #initialization }
ToTreeElement >> defaultNodeManagerClass [

	^ ToGenericTreeNodeManager  
]

{ #category : #initialization }
ToTreeElement >> initialize [ 

	super initialize.
	nodeManager treeElement: self.
]
