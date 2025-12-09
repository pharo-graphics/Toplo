Class {
	#name : #ToMultiSelectPopupListNodeManager,
	#superclass : #ToSelectPopupListNodeManager,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #'t - generic node manager' }
ToMultiSelectPopupListNodeManager >> newHolder [ 

	^ ToMultiSelectPopupListNodeHolder new
]
