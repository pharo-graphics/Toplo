Class {
	#name : #ToItemListElement,
	#superclass : #ToBasicListElement,
	#traits : 'TToItemListElement',
	#classTraits : 'TToItemListElement classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemListElement >> defaultNodeManagerClass [

	^ ToItemListNodeManager
]

{ #category : #initialization }
ToItemListElement >> initialize [

	super initialize.
	self initializeAsItemListElement 
]

{ #category : #skin }
ToItemListElement >> newRawSkin [ 

	^ ToItemListElementSkin new
]
