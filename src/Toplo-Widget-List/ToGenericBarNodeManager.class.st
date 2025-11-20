Class {
	#name : #ToGenericBarNodeManager,
	#superclass : #ToAbstractBarNodeManager,
	#traits : 'TToGenericNodeManager + TToListGenericCheckableNodeBuilder',
	#classTraits : 'TToGenericNodeManager classTrait + TToListGenericCheckableNodeBuilder classTrait',
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #'t - generic node manager' }
ToGenericBarNodeManager >> defaultNodeFactory [

	^ [ :holder | ToBarNode new ]
]

{ #category : #initialization }
ToGenericBarNodeManager >> initialize [ 

	super initialize.
	self initializeAsGenericNodeManager 
]
