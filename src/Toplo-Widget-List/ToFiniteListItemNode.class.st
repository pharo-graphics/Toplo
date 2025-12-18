Class {
	#name : #ToFiniteListItemNode,
	#superclass : #ToFiniteListNode,
	#traits : 'TToItemNode',
	#classTraits : 'TToItemNode classTrait',
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #configuration }
ToFiniteListItemNode >> applyConfiguration [

	super applyConfiguration.
	self nodeManager configureItem: self item
]

{ #category : #initialization }
ToFiniteListItemNode >> initialize [

	super initialize.
	self initializeAsItemNode 
]
