Class {
	#name : #ToMultiSelectListNodeManager,
	#superclass : #ToSelectListNodeManager,
	#category : #'Toplo-Widget-Select-manager'
}

{ #category : #'t - generic node manager' }
ToMultiSelectListNodeManager >> newHolder [ 

	^ ToMultiSelectListNodeHolder new
]
