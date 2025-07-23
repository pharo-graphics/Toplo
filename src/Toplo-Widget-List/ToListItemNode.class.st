Class {
	#name : #ToListItemNode,
	#superclass : #ToListNode,
	#traits : 'TToItemNode',
	#classTraits : 'TToItemNode classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToListItemNode >> initialize [

	super initialize.
	self initializeAsItemNode 
]
