Class {
	#name : #ToGenericFiniteListNodeManager,
	#superclass : #ToAbstractFiniteNodeManager,
	#traits : 'TToGenericNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait',
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #'t - generic node manager' }
ToGenericFiniteListNodeManager >> defaultNodeFactory [

	^ [ :holder | ToFiniteListNode new ]
]

{ #category : #initialization }
ToGenericFiniteListNodeManager >> initialize [ 

	super initialize.
	self initializeAsGenericNodeManager 
]
