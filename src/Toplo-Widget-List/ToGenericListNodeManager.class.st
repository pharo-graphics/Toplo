Class {
	#name : #ToGenericListNodeManager,
	#superclass : #ToListNodeManager,
	#traits : 'TToGenericNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait',
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToGenericListNodeManager >> initialize [

	super initialize.
	self initializeAsGenericNodeManager 
]
