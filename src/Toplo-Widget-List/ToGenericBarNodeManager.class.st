Class {
	#name : #ToGenericBarNodeManager,
	#superclass : #ToAbstractBarNodeManager,
	#traits : 'TToGenericNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait',
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #'t - generic node manager' }
ToGenericBarNodeManager >> defaultNodeFactory [

	^ [ :holder | ToFiniteListNode new ]
]

{ #category : #initialization }
ToGenericBarNodeManager >> initialize [ 

	super initialize.
	self initializeAsGenericNodeManager 
]
