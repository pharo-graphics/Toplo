Class {
	#name : #ToGenericFiniteListNodeManager,
	#superclass : #ToAbstractNodeManager,
	#traits : 'TToFiniteNodeManager + TToGenericNodeManager',
	#classTraits : 'TToFiniteNodeManager classTrait + TToGenericNodeManager classTrait',
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #'t - generic node manager' }
ToGenericFiniteListNodeManager >> defaultNodeFactory [

	^ [ :holder | ToFiniteListNode new ]
]

{ #category : #initialization }
ToGenericFiniteListNodeManager >> initialize [ 

	super initialize.
	self initializeAsFiniteNodeManager.
	self initializeAsGenericNodeManager 
]
