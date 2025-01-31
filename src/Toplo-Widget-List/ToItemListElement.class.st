Class {
	#name : #ToItemListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToItemBarElement',
	#classTraits : 'TToItemBarElement classTrait',
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #initialization }
ToItemListElement >> defaultInnerElement [

	^ ToInfiniteElement onListElement: self
]

{ #category : #initialization }
ToItemListElement >> initialize [

	super initialize.
	self initializeAsItemBarElement 
]
