Class {
	#name : #ToListItemNode,
	#superclass : #ToBasicListNode,
	#traits : 'TToItemNode',
	#classTraits : 'TToItemNode classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #configuration }
ToListItemNode >> applyConfiguration [ 

	super applyConfiguration.
	self nodeManager configureItem: self item
]

{ #category : #initialization }
ToListItemNode >> initialize [

	super initialize.
	self initializeAsItemNode 
]
