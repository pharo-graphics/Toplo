Class {
	#name : #ToClassHierachyTreeElement,
	#superclass : #ToAbstractTreeElement,
	#traits : 'TToListElementWithDecoration',
	#classTraits : 'TToListElementWithDecoration classTrait',
	#category : #'Toplo-Widget-Tree-examples'
}

{ #category : #examples }
ToClassHierachyTreeElement class >> example [
	"This example shows classes as a list but using TreeNodes, tree logic is not implemented at this time of writing the example"

	| l |
	l := self new.
	l withRowNumbers.
	l dataAccessor add: Object.

	l contextMenu: [ :menu :request |
		| selectionModel indexes target |
		target := request currentTarget.
		selectionModel := request selectionModel.
		indexes := request selectedIndexes.
		menu addItem: (ToMenuItem new
				 labelText: 'Expand all';
				 clickAction: [
					 indexes do: [ :idx | (target dataSource at: idx) expandAll ] ];
				 yourself).
		menu addItem: (ToMenuItem new
				 labelText: 'Collapse all';
				 clickAction: [ target collapseAll ];
				 yourself) ].

	l openInSpace
]

{ #category : #initialization }
ToClassHierachyTreeElement >> defaultNodeManagerClass [ 

	^ ToClassHierachyTreeNodeManager
]
