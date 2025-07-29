"
I'm a list whose node contents is a BlElement
"
Class {
	#name : #ToItemBarElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToConfigurableBarElement + TToBarElement + TToItemList',
	#classTraits : 'TToConfigurableBarElement classTrait + TToBarElement classTrait + TToItemList classTrait',
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #configuration }
ToItemBarElement >> applyConfiguration [ 

	super applyConfiguration.
	self applyItemListConfiguration
]

{ #category : #initialization }
ToItemBarElement >> defaultNodeManagerClass [

	^ ToItemBarNodeManager
]

{ #category : #initialization }
ToItemBarElement >> initialize [

	super initialize.
	self initializeAsItemListElement
]

{ #category : #skin }
ToItemBarElement >> newRawSkin [ 

	^ ToItemBarElementSkin new
]

{ #category : #'t - item list - adding/removing' }
ToItemBarElement >> notifyItemAdded: anItem [

	self dispatchEvent: (ToItemAddedInBarEvent new
			 item: anItem;
			 yourself)
]

{ #category : #'t - item list - adding/removing' }
ToItemBarElement >> notifyItemRemoved: anItem wasSelected: aBoolean [

	self dispatchEvent: (ToItemRemovedFromBarEvent new
			 item: anItem;
			 wasSelected: aBoolean;
			 yourself)
]
