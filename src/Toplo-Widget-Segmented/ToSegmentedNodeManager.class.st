Class {
	#name : #ToSegmentedNodeManager,
	#superclass : #ToBarNodeManager,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #initialization }
ToSegmentedNodeManager >> defaultFakeDataItem [ 

	^ ToToggleButton new
]

{ #category : #initialization }
ToSegmentedNodeManager >> defaultHolderClass [

	^ ToSegmentedNodeHolder
]

{ #category : #initialization }
ToSegmentedNodeManager >> defaultNodeBuilder [

	^ [ :node :checkableElement :holder |
		" in a segmented, the dataItem is a checkable element "
	  node checkableElement: checkableElement ]
]

{ #category : #initialization }
ToSegmentedNodeManager >> defaultNodeFactory [

	^ [ :holder | ToSegmentedNode new ]
]

{ #category : #initialization }
ToSegmentedNodeManager >> unbuildNode: aNode [

	aNode isFake ifFalse: [ aNode checkableElement unregisterFromGroup ].
	aNode checkableElement removeFromParent.
	super unbuildNode: aNode
]
