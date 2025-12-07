Class {
	#name : #ToMultiSelectHeaderNodeManager,
	#superclass : #ToAbstractNodeManager,
	#traits : 'TToGenericNodeManager + TToFiniteNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait + TToFiniteNodeManager classTrait',
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
	self initializeAsGenericNodeManager.
	self initializeAsFiniteNodeManager
]

{ #category : #'t - generic node manager' }
ToMultiSelectHeaderNodeManager >> newNodeContainer [ 

	^ ToMultiSelectHeaderNodeContainer new
]
