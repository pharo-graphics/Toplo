Class {
	#name : #ToItemListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToItemList + TToListElementWithDecoration',
	#classTraits : 'TToItemList classTrait + TToListElementWithDecoration classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #configuration }
ToItemListElement >> applyDownwardConfiguration [ 

	super applyDownwardConfiguration.
	self applyItemListConfiguration
]

{ #category : #initialization }
ToItemListElement >> defaultInnerElement [

	^ ToInfiniteElement onListElement: self
]

{ #category : #'t - item list - accessing' }
ToItemListElement >> defaultNodeManagerClass [

	^ ToItemListNodeManager
]

{ #category : #initialization }
ToItemListElement >> initialize [

	super initialize.
	self initializeAsItemListElement 
]
