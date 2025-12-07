"
I'm a list whose node contents is a BlElement
"
Class {
	#name : #ToItemFiniteListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToConfigurableFiniteListElement + TToFiniteListElement + TToItemList',
	#classTraits : 'TToConfigurableFiniteListElement classTrait + TToFiniteListElement classTrait + TToItemList classTrait',
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #configuration }
ToItemFiniteListElement >> applyConfiguration [ 

	super applyConfiguration.
	self applyItemListConfiguration
]

{ #category : #initialization }
ToItemFiniteListElement >> defaultNodeManagerClass [

	^ ToItemFiniteListNodeManager
]

{ #category : #initialization }
ToItemFiniteListElement >> initialize [

	super initialize.
	self initializeAsFiniteListElement.
	self initializeAsItemListElement
]

{ #category : #skin }
ToItemFiniteListElement >> newRawSkin [ 

	^ ToItemFiniteListElementSkin new
]

{ #category : #'t - item list - adding/removing' }
ToItemFiniteListElement >> notifyItemAdded: anItem [

	self dispatchEvent: (ToItemAddedInFiniteListEvent new
			 item: anItem;
			 yourself)
]

{ #category : #'t - item list - adding/removing' }
ToItemFiniteListElement >> notifyItemRemoved: anItem wasSelected: aBoolean [

	self dispatchEvent: (ToItemRemovedFromFiniteListEvent new
			 item: anItem;
			 wasSelected: aBoolean;
			 yourself)
]
