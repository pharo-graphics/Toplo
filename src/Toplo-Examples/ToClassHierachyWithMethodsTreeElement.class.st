Class {
	#name : #ToClassHierachyWithMethodsTreeElement,
	#superclass : #ToAbstractTreeElement,
	#category : #'Toplo-Examples-TopLevel-Tree'
}

{ #category : #examples }
ToClassHierachyWithMethodsTreeElement class >> example [
	"This example shows classes as a list but using TreeNodes, tree logic is not implemented at this time of writing the example"

	| l |
	l := self new.
	l dataAccessor add: BlElement.
	l dataAccessor add: Collection.
	l dataAccessor add: String.
	l openInSpace
]

{ #category : #initialization }
ToClassHierachyWithMethodsTreeElement >> defaultNodeManagerClass [ 

	^ ToClassHierachyWithMethodsTreeNodeManager
]
