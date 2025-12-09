Class {
	#name : #ToWrappedListNodeManager,
	#superclass : #ToAbstractNodeManager,
	#category : #'Toplo-Widget-List-WrappedList'
}

{ #category : #'node building' }
ToWrappedListNodeManager >> buildNode: aNode [

	aNode addChild: (ToLabel text: aNode holder dataItem asString)
]

{ #category : #'instance creation' }
ToWrappedListNodeManager >> newHolder [

	^ ToWrappedListNodeHolder new
]

{ #category : #'instance creation' }
ToWrappedListNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToListNode new
]
