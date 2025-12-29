"
I'm a list whose node contents is a BlElement
"
Class {
	#name : #ToItemFiniteListElement,
	#superclass : #ToItemListElement,
	#traits : 'TToFiniteListElement',
	#classTraits : 'TToFiniteListElement classTrait',
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #configuration }
ToItemFiniteListElement >> applyConfiguration [ 

	super applyConfiguration.
	self applyItemListConfiguration
]

{ #category : #'t - finite list element - fake container' }
ToItemFiniteListElement >> defaultFakeDataItem [

	^ ToListItem new
]

{ #category : #initialization }
ToItemFiniteListElement >> defaultNodeManagerClass [

	^ ToItemListNodeManager
]

{ #category : #initialization }
ToItemFiniteListElement >> defaultUseInfiniteLayout [ 

	^ false
]

{ #category : #initialization }
ToItemFiniteListElement >> initialize [

	super initialize.
	self initializeAsItemListElement
]

{ #category : #skin }
ToItemFiniteListElement >> newRawSkin [ 

	^ ToItemListElementSkin new
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
