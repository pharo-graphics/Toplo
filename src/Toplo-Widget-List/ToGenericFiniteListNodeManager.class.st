Class {
	#name : #ToGenericFiniteListNodeManager,
	#superclass : #ToFiniteListNodeManager,
	#traits : 'TToGenericNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait',
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #initialization }
ToGenericFiniteListNodeManager >> defaultNodeFactory [

	^ [ :holder | ToFiniteListNode new ]
]

{ #category : #initialization }
ToGenericFiniteListNodeManager >> initialize [ 

	super initialize.
	self initializeAsGenericNodeManager 
]
