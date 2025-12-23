Class {
	#name : #ToWrappedListNodeManager,
	#superclass : #ToBasicListNodeManager,
	#category : #'Toplo-Widget-List-WrappedList'
}

{ #category : #initialization }
ToWrappedListNodeManager >> defaultNodeHolderFactory [ 

	^ [ ToWrappedListNodeHolder new ]
]
