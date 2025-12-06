Class {
	#name : #ToMultiSelectPopupNodeManager,
	#superclass : #ToGenericFiniteListNodeManager,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'t - generic node manager' }
ToMultiSelectPopupNodeManager >> defaultNodeBuilder [

	^ [ :node :dataItem :holder |
		  node
			  labelText: dataItem asString;
			  removable: true;
			  hMatchParent ]
]

{ #category : #'t - generic node manager' }
ToMultiSelectPopupNodeManager >> defaultNodeFactory [

	^ [ :holder | ToMultiSelectNode new ]
]

{ #category : #'t - generic node manager' }
ToMultiSelectPopupNodeManager >> defaultNodeHolderFactory [

	^ [ ToMultiSelectHolder new ]
]

{ #category : #'t - generic node manager' }
ToMultiSelectPopupNodeManager >> newNodeContainer [ 

	^ ToMultiSelectPopupNodeContainer new
]
