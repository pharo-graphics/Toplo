Class {
	#name : #ToGenericBarNodeManager,
	#superclass : #ToAbstractBarNodeManager,
	#traits : 'TToGenericNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait',
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #'t - generic node manager' }
ToGenericBarNodeManager >> buildNode: aNode [

	nodeBuilder
		cull: aNode
		cull: aNode holder dataItem
		cull: aNode holder
]

{ #category : #'t - generic node manager' }
ToGenericBarNodeManager >> defaultNodeFactory [

	^ [ :holder | ToBarNode new ]
]

{ #category : #initialization }
ToGenericBarNodeManager >> initialize [ 

	super initialize.
	self initializeAsGenericNodeManager 
]
