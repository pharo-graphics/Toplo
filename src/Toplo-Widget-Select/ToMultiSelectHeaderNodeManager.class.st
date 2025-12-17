Class {
	#name : #ToMultiSelectHeaderNodeManager,
	#superclass : #ToListNodeManager,
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

{ #category : #initialization }
ToMultiSelectHeaderNodeManager >> defaultNodeFactory [

	^ [ :holder | ToMultiSelectHeaderNode new ]
]

{ #category : #initialization }
ToMultiSelectHeaderNodeManager >> defaultNodeHolderFactory [

	^ [ ToMultiSelectHeaderHolder new ]
]

{ #category : #initialization }
ToMultiSelectHeaderNodeManager >> initialize [ 

	super initialize.
	self initializeAsGenericNodeManager
]
