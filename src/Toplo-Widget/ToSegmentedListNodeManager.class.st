Class {
	#name : #ToSegmentedListNodeManager,
	#superclass : #ToCheckableListNodeManager,
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToSegmentedListNodeManager >> defaultNodeContainerFactory [

	^ [ ToSegmentedNodeContainer new ]
]
