Class {
	#name : #ToWrappedListNodeManager,
	#superclass : #ToBasicListNodeManager,
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToWrappedListNodeManager >> defaultNodeHolderFactory [ 

	^ [ ToWrappedListNodeHolder new ]
]
