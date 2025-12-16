Class {
	#name : #ToWrappedListNodeManager,
	#superclass : #ToListNodeManager,
	#category : #'Toplo-Widget-List-WrappedList'
}

{ #category : #initialization }
ToWrappedListNodeManager >> defaultNodeHolderFactory [ 

	^ [ ToWrappedListNodeHolder new ]
]
