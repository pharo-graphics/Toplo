Class {
	#name : #ToExClassHierachyWithMethodsTreeElement,
	#superclass : #ToAbstractTreeElement,
	#category : #'Toplo-Examples-TopLevel-Trees'
}

{ #category : #examples }
ToExClassHierachyWithMethodsTreeElement class >> example [
	"This example shows classes as a list but using TreeNodes, tree logic is not implemented at this time of writing the example"

	| l |
	l := self new.
	l withRowNumbers.
	l contextMenu: [ :menu :request |
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
	l dataAccessor add: ProtoObject.
	"l dataAccessor add: Collection.
	l dataAccessor add: String."
	l openInSpace
]

{ #category : #initialization }
ToExClassHierachyWithMethodsTreeElement >> defaultNodeManagerClass [ 

	^ ToExClassHierachyWithMethodsTreeNodeManager
]
