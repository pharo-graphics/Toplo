Class {
	#name : #ToTabNode,
	#superclass : #ToListCheckableNode,
	#traits : 'TToRemovableNode',
	#classTraits : 'TToRemovableNode classTrait',
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #configuration }
ToTabNode >> applyConfiguration [

	super applyConfiguration.
	self isRemovable
		ifTrue: [ self addRemoveButton ]
		ifFalse: [ self removeRemoveButton ].
	self requestNewSkin
]

{ #category : #'t - item node' }
ToTabNode >> newRawSkin [ 

	^ ToTabNodeSkin new
]
