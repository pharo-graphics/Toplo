Class {
	#name : #ToSegmentedListNodeManager,
	#superclass : #ToCheckableListNodeManager,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToSegmentedListNodeManager >> defaultNodeContainerFactory [

	^ [ ToSegmentedNodeContainer new ]
]
