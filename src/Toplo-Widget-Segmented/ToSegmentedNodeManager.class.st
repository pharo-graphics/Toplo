Class {
	#name : #ToSegmentedNodeManager,
	#superclass : #ToBarNodeManager,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'instance creation' }
ToSegmentedNodeManager >> buildFakeNode: aFakeNode inHolder: anHolder [

	| contentElement |
	contentElement := ToLabeledIcon new
		                  labelText: self fakeDataItem asString;
		                  yourself.
	anHolder dataItem: contentElement.
	super buildFakeNode: aFakeNode inHolder: anHolder
]

{ #category : #initialization }
ToSegmentedNodeManager >> defaultNodeBuilder [

	^ [ :node :contentElement :holder |
	  node isFake ifFalse: [
		  contentElement registerInGroup: holder segmentedBarElement group.
		  contentElement constraints infinite holder: holder.
		  contentElement constraintsDo: [ :c | c horizontal matchParent ] ].
	  node addChild: contentElement ]
]

{ #category : #initialization }
ToSegmentedNodeManager >> defaultNodeFactory [

	^ [ :holder | ToSegmentedNode new ]
]

{ #category : #initialization }
ToSegmentedNodeManager >> defaultNodeHolderClass [

	^ ToSegmentedNodeHolder
]

{ #category : #initialization }
ToSegmentedNodeManager >> unbuildNode: aNode [

	aNode isFake ifFalse: [
		  aNode content unregisterFromGroup ].
	aNode content removeFromParent.
	super unbuildNode: aNode
]
