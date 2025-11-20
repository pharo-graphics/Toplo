Trait {
	#name : #TToGenericListElement,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - generic list element' }
TToGenericListElement >> nodeBuilder: aValuable [
	"aValuable takes 3 optional args: first, the node to build, second, the dataItem and third, the holder in the list element "

	self nodeManager nodeBuilder: aValuable
]

{ #category : #'t - generic list element' }
TToGenericListElement >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	self nodeManager nodeFactory: aValuable
]

{ #category : #'t - generic list element' }
TToGenericListElement >> nodeUnbuilder: aValuable [

	"aValuable takes 3 args: first, the node to build and second, its holder in the list element and the data item"
	self nodeManager nodeUnbuilder: aValuable
]

{ #category : #'t - generic list element' }
TToGenericListElement >> useCheckbox: aBoolean [

	self nodeManager checkableNode: aBoolean.
	self onUseCheckboxChangedWith: aBoolean
]
