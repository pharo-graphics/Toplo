Class {
	#name : #ToMultiSelectHeaderNodeManager,
	#superclass : #ToAbstractFiniteNodeManager,
	#traits : 'TToGenericNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait',
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'t - generic node manager' }
ToMultiSelectHeaderNodeManager >> defaultNodeBuilder [

	^ [ :node :dataItem :holder |
		  node
			  labelText: dataItem asString;
			  removable: true;
			  hMatchParent ]
]

{ #category : #'t - generic node manager' }
ToMultiSelectHeaderNodeManager >> defaultNodeFactory [

	^ [ :holder | ToMultiSelectNode new ]
]

{ #category : #'t - generic node manager' }
ToMultiSelectHeaderNodeManager >> defaultNodeHolderFactory [

	^ [ ToMultiSelectHolder new ]
]

{ #category : #initialization }
ToMultiSelectHeaderNodeManager >> initialize [ 

	super initialize.
	self initializeAsGenericNodeManager
]

{ #category : #'t - finite node manager - initialization' }
ToMultiSelectHeaderNodeManager >> newNodeContainer [ 

	^ ToMultiSelectHeaderNodeContainer new
]
