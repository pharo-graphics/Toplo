Class {
	#name : #ToItemListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToItemListElement + TToListElementWithDecoration',
	#classTraits : 'TToItemListElement classTrait + TToListElementWithDecoration classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #configuration }
ToItemListElement >> applyConfiguration [ 

	super applyConfiguration.
	self applyItemListConfiguration
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
