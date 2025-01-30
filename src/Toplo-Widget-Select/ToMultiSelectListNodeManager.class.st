Class {
	#name : #ToMultiSelectListNodeManager,
	#superclass : #ToGenericListNodeManager,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'t - generic node manager' }
ToMultiSelectListNodeManager >> newHolder [ 

	^ ToMultiSelectListNodeHolder new
]
