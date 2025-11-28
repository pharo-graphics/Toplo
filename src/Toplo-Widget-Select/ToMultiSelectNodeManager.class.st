Class {
	#name : #ToMultiSelectNodeManager,
	#superclass : #ToGenericBarNodeManager,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'t - generic node manager' }
ToMultiSelectNodeManager >> defaultNodeBuilder [

	^ [ :node :dataItem :holder |
		  node addChild: (ToTagElement new
				   labelText: dataItem asString;
				   removable: true;
				   hMatchParent;
				   yourself) ]
]

{ #category : #'t - generic node manager' }
ToMultiSelectNodeManager >> newHolder [ 

	^ ToMultiSelectHolder new
]
