Class {
	#name : #ToFiniteListItemNode,
	#superclass : #ToFiniteListNode,
	#traits : 'TToItemNode',
	#classTraits : 'TToItemNode classTrait',
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #initialization }
ToFiniteListItemNode >> initialize [

	super initialize.
	self initializeAsItemNode 
]

{ #category : #skin }
ToFiniteListItemNode >> newRawSkin [ 

	^ ToItemNodeSkin new
]
