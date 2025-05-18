Class {
	#name : #ToTreeElement,
	#superclass : #ToAbstractTreeElement,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #examples }
ToTreeElement class >> exampleClassHierarchiesWithMethods [
	"For this example we created a new wrapper dealing with classes and methods at the same time, a new Node was also created (ToTreeSubAndMethNode) to apply a new skin (ToTreeNodeSubAndMethSkin) with new icons and a different background color for methods "

	| l |
	l := self new.
	l nodeManager childrenGetter: [ :dataItem |
		dataItem isClass
			ifTrue: [
				Array streamContents: [ :stream |
					stream nextPutAll: dataItem subclasses.
					stream nextPutAll:
						(dataItem methods collect: [ :each | each selector ]) sorted ] ]
			ifFalse: [ #(  ) ] ].
	l nodeManager nodeFactory: [ :holder | ToTreeSubAndMethNode new ].
	l dataAccessor add: BlElement.
	l dataAccessor add: Collection.
	l dataAccessor add: String.

	l openInSpace
]

{ #category : #examples }
ToTreeElement class >> examplePreviousIntegers [
	"This example shows classes as a list but using TreeNodes, tree logic is not implemented at this time of writing the example"

	| l |
	l := self new.
	l nodeManager childrenGetter: [ :dataItem |
		dataItem = 1
			ifTrue: [ {  } ]
			ifFalse: [ { (dataItem - 1) } ] ].
	l dataAccessor addAll: (1 to: 10).
	l openInSpace
]

{ #category : #examples }
ToTreeElement class >> exampleProtoObjectSubclasses [
	"This example shows classes as a list but using TreeNodes, tree logic is not implemented at this time of writing the example"

	| l |
	l := self new.
	l nodeManager childrenGetter: [ :dataItem | dataItem subclasses asOrderedCollection ].
	l dataAccessor add: ProtoObject.
	l openInSpace
]

{ #category : #initialization }
ToTreeElement >> defaultNodeManagerClass [ 

	^ ToGenericTreeNodeManager
]
