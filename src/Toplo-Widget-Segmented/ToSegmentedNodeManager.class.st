Class {
	#name : #ToSegmentedNodeManager,
	#superclass : #ToAbstractBarNodeManager,
	#category : #'Toplo-Widget-Segmented-Node'
}

{ #category : #initialization }
ToSegmentedNodeManager >> buildNode: aNode [

	| checkableElement holder |
	holder := aNode holder.
	checkableElement := holder dataItem.
	aNode checkableElement: checkableElement.
	"the TToCheckable must be registered in the checkable group managed by the segmented bar"
	checkableElement registerInGroup: holder listElement group
]

{ #category : #initialization }
ToSegmentedNodeManager >> defaultFakeDataItem [ 

	^ ToSegmentedButton new
]

{ #category : #'instance creation' }
ToSegmentedNodeManager >> newHolder [

	^ ToListNodeHolder new
]

{ #category : #'instance creation' }
ToSegmentedNodeManager >> newNodeForHolder: aNodeHolder [

	^ ToSegmentedNode new
]

{ #category : #initialization }
ToSegmentedNodeManager >> unbuildNode: aNode [

	aNode checkableElement unregisterFromGroup.
	aNode checkableElement removeFromParent
]
