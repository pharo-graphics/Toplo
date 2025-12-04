Class {
	#name : #ToMultiSelectNodeManager,
	#superclass : #ToGenericFiniteListNodeManager,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'t - generic node manager' }
ToMultiSelectNodeManager >> defaultNodeBuilder [

	^ [ :node :dataItem :holder |
		  node
			  labelText: dataItem asString;
			  removable: true;
			  hMatchParent ]
]

{ #category : #'t - generic node manager' }
ToMultiSelectNodeManager >> defaultNodeFactory [

	^ [ :holder | ToMultiSelectNode new ]
]

{ #category : #'t - generic node manager' }
ToMultiSelectNodeManager >> defaultNodeHolderFactory [

	^ [ ToMultiSelectHolder new ]
]
