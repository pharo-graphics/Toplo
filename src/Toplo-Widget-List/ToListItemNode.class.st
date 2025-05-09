Class {
	#name : #ToListItemNode,
	#superclass : #ToListNode,
	#traits : 'TToItemNode',
	#classTraits : 'TToItemNode classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #configuration }
ToListItemNode >> applyWidgetConfiguration [

	super applyWidgetConfiguration.
	self applyItemNodeConfiguration
]

{ #category : #initialization }
ToListItemNode >> initialize [

	super initialize.
	self initializeAsItemNode 
]
