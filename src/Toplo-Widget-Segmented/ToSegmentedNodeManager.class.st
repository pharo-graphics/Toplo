Class {
	#name : #ToSegmentedNodeManager,
	#superclass : #ToGenericBarNodeManager,
	#category : #'Toplo-Widget-Segmented-Node'
}

{ #category : #initialization }
ToSegmentedNodeManager >> defaultFakeDataItem [ 

	^ ToSegmentedButton new
]

{ #category : #initialization }
ToSegmentedNodeManager >> defaultHolderClass [

	^ ToSegmentedNodeHolder
]

{ #category : #initialization }
ToSegmentedNodeManager >> defaultNodeBuilder [

	^ [ :node :checkableElement :holder |
		" in a segmented, the dataItem is a TToCheckable "
	  node checkableElement: checkableElement ]
]

{ #category : #initialization }
ToSegmentedNodeManager >> defaultNodeFactory [

	^ [ :holder | ToSegmentedNode new ]
]

{ #category : #initialization }
ToSegmentedNodeManager >> defaultNodeUnbuilder [

	^ [ :node :checkableElement :holder | 
	  " in a segmented, the dataItem is a TToCheckable "
	  node checkableElement unregisterFromGroup.
	  node checkableElement removeFromParent ]
]
