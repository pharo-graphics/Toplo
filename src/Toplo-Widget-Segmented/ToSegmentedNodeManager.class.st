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
ToSegmentedNodeManager >> constraintNode: aNode [

	| seg |
	super constraintNode: aNode.
	seg := aNode holder checkableBarElement.
	aNode childrenDo: [ :child |
		child constraintsDo: [ :c |
			c linear vertical alignCenter.
			c linear horizontal alignCenter.
			c horizontal matchParent.
			c vertical matchParent ] ].
	seg isHorizontal ifTrue: [ ^ self ].
	seg canMatchParentHorizontallyInVerticalSegmented ifFalse: [ ^ self ].
	aNode constraintsDo: [ :c | c horizontal matchParent ]
]

{ #category : #initialization }
ToSegmentedNodeManager >> defaultNodeBuilder [

	^ [ :node :holder :contentElement |
	  node isFake ifFalse: [
		  contentElement registerInGroup: holder checkableBarElement group.
		  contentElement constraints infinite holder: holder ].
	"contentElement withNullSkin."
	  node addChild: contentElement ]
]

{ #category : #initialization }
ToSegmentedNodeManager >> defaultNodeFactory [

	^ [ :holder |
	  ToSegmentedNode new ]
]

{ #category : #initialization }
ToSegmentedNodeManager >> defaultNodeHolderClass [

	^ ToSegmentedNodeHolder
]

{ #category : #initialization }
ToSegmentedNodeManager >> unbindNode: aNode [

	aNode isFake ifFalse: [
		  aNode content unregisterFromGroup ].
	aNode holder contentElement removeFromParent.
	super unbindNode: aNode
]
