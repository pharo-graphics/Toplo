Class {
	#name : #ToExClassHierachyTreeElement,
	#superclass : #ToBasicTreeElement,
	#traits : 'TToListElementWithDecoration',
	#classTraits : 'TToListElementWithDecoration classTrait',
	#category : #'Toplo-Examples-TopLevel-Trees'
}

{ #category : #examples }
ToExClassHierachyTreeElement class >> example [
	"This example shows classes as a list but using TreeNodes, tree logic is not implemented at this time of writing the example"

	| l |
	l := self new.
	l withRowNumbers.
	l dataAccessor add: Object.

	l contextMenuBuilder: [ :menu :request |
			| selectionModel indexes target |
			target := request currentTarget.
			selectionModel := request selectionModel.
			indexes := request selectedIndexes.
			menu addItem: (ToMenuItem new
					 labelText: 'Expand all';
					 clickAction: [
							 indexes
								 ifEmpty: [ target expandAll ]
								 ifNotEmpty: [
									 indexes do: [ :idx | (target dataSource at: idx) expandAll ] ] ];
					 yourself).
			menu addItem: (ToMenuItem new
					 labelText: 'Collapse all';
					 clickAction: [
							 indexes
								 ifEmpty: [ target collapseAll ]
								 ifNotEmpty: [
									 indexes do: [ :idx | (target dataSource at: idx) collapse ] ] ];
					 yourself) ].

	l openInSpace
]

{ #category : #initialization }
ToExClassHierachyTreeElement >> defaultNodeManagerClass [ 

	^ ToExClassHierachyTreeNodeManager
]
