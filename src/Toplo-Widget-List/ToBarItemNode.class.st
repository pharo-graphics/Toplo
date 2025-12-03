Class {
	#name : #ToBarItemNode,
	#superclass : #ToBarNode,
	#traits : 'TToItemNode',
	#classTraits : 'TToItemNode classTrait',
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #initialization }
ToBarItemNode >> initialize [

	super initialize.
	self initializeAsItemNode 
]
