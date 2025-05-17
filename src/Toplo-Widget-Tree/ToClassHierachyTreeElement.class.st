Class {
	#name : #ToClassHierachyTreeElement,
	#superclass : #ToAbstractTreeElement,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #examples }
ToClassHierachyTreeElement class >> exampleProtoObjectSubclasses [
	"This example shows classes as a list but using TreeNodes, tree logic is not implemented at this time of writing the example"

	| l |
	l := self new.
	l dataAccessor add: ProtoObject.
	l openInSpace
]

{ #category : #accessing }
ToClassHierachyTreeElement >> dataWrapperClass [

	^ ToTreeDataItemClassWrapper 
]
