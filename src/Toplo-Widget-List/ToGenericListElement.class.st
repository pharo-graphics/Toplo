Class {
	#name : #ToGenericListElement,
	#superclass : #ToAbstractListElement,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToGenericListElement >> defaultNodeManagerClass [

	^ ToGenericListNodeManager  
]

{ #category : #accessing }
ToGenericListElement >> nodeBuilder: aValuable [
	"aValuable takes 3 optional args: first, the node to build, second, the dataItem and third, the holder in the list element "

	nodeManager nodeBuilder: aValuable
]

{ #category : #accessing }
ToGenericListElement >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	nodeManager nodeFactory: aValuable
]

{ #category : #accessing }
ToGenericListElement >> nodeHolderClass: aNodeHolderClass [

	nodeManager holderClass: aNodeHolderClass
]

{ #category : #accessing }
ToGenericListElement >> nodeUnbuilder: aValuable [

	"aValuable takes 3 args: first, the node to build and second, its holder in the list element and the data item"
	nodeManager nodeUnbuilder: aValuable
]
