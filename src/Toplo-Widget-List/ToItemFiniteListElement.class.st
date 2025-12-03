"
I'm a list whose node contents is a BlElement
"
Class {
	#name : #ToItemFiniteListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToConfigurableBarElement + TToFiniteListElement + TToItemList',
	#classTraits : 'TToConfigurableBarElement classTrait + TToFiniteListElement classTrait + TToItemList classTrait',
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #configuration }
ToItemFiniteListElement >> applyConfiguration [ 

	super applyConfiguration.
	self applyItemListConfiguration
]

{ #category : #initialization }
ToItemFiniteListElement >> defaultNodeManagerClass [

	^ ToItemBarNodeManager
]

{ #category : #initialization }
ToItemFiniteListElement >> initialize [

	super initialize.
	self initializeAsBarElement.
	self initializeAsItemListElement
]

{ #category : #skin }
ToItemFiniteListElement >> newRawSkin [ 

	^ ToItemBarElementSkin new
]

{ #category : #'t - item list - adding/removing' }
ToItemFiniteListElement >> notifyItemAdded: anItem [

	self dispatchEvent: (ToItemAddedInBarEvent new
			 item: anItem;
			 yourself)
]

{ #category : #'t - item list - adding/removing' }
ToItemFiniteListElement >> notifyItemRemoved: anItem wasSelected: aBoolean [

	self dispatchEvent: (ToItemRemovedFromBarEvent new
			 item: anItem;
			 wasSelected: aBoolean;
			 yourself)
]
