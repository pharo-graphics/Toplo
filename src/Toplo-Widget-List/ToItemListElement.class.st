Class {
	#name : #ToItemListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToItemListElement + TToListElementWithDecoration',
	#classTraits : 'TToItemListElement classTrait + TToListElementWithDecoration classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemListElement >> defaultInnerElement [

	^ ToInfiniteElement onListElement: self
]

{ #category : #'t - item bar element - accessing' }
ToItemListElement >> defaultNodeManagerClass [

	^ ToItemListNodeManager
]

{ #category : #initialization }
ToItemListElement >> initialize [

	super initialize.
	self initializeAsItemBarElement 
]
