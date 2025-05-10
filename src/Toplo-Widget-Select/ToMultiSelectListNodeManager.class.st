Class {
	#name : #ToMultiSelectListNodeManager,
	#superclass : #ToSelectListNodeManager,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'t - generic node manager' }
ToMultiSelectListNodeManager >> newHolder [ 

	^ ToMultiSelectListNodeHolder new
]
