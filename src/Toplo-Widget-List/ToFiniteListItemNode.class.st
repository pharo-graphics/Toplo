Class {
	#name : #ToFiniteListItemNode,
	#superclass : #ToFiniteListNode,
	#traits : 'TToItemNode',
	#classTraits : 'TToItemNode classTrait',
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #initialization }
ToFiniteListItemNode >> initialize [

	super initialize.
	self initializeAsItemNode 
]
