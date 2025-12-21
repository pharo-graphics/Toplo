Class {
	#name : #ToItemListElement,
	#superclass : #ToBasicListElement,
	#traits : 'TToItemListElement + TToListElementWithDecoration',
	#classTraits : 'TToItemListElement classTrait + TToListElementWithDecoration classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #configuration }
ToItemListElement >> applyConfiguration [ 

	super applyConfiguration.
	self applyItemListConfiguration
]

{ #category : #'t - finite list element - fake container' }
ToItemListElement >> defaultFakeDataItem [

	^ ToFiniteListItem new
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
