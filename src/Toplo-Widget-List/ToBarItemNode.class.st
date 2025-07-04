Class {
	#name : #ToBarItemNode,
	#superclass : #ToBarNode,
	#traits : 'TToItemNode',
	#classTraits : 'TToItemNode classTrait',
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #configuration }
ToBarItemNode >> applyWidgetConfiguration [

	super applyWidgetConfiguration.
	self applyItemNodeConfiguration
]

{ #category : #initialization }
ToBarItemNode >> initialize [

	super initialize.
	self initializeAsItemNode 
]
