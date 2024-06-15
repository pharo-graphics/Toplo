Class {
	#name : #ToCheckableNodeManager,
	#superclass : #ToBarNodeManager,
	#category : #'Toplo-Widget-CheckableBar'
}

{ #category : #'instance creation' }
ToCheckableNodeManager >> buildFakeNode: aFakeNode inHolder: anHolder [

	| contentElement |
	contentElement := ToLabeledIcon new
		                  labelText: self fakeDataItem asString;
		                  yourself.
	anHolder dataItem: contentElement.
	super buildFakeNode: aFakeNode inHolder: anHolder
]

{ #category : #initialization }
ToCheckableNodeManager >> defaultNodeBuilder [

	^ [ :node :holder :contentElement |
	  node isFake ifFalse: [
		  contentElement registerInGroup: holder checkableBarElement group ].
	  node addChild: contentElement ]
]

{ #category : #initialization }
ToCheckableNodeManager >> defaultNodeFactory [

	^ [ :holder |
	  ToCheckableNode new ]
]

{ #category : #initialization }
ToCheckableNodeManager >> defaultNodeHolderClass [

	^ ToCheckableNodeHolder
]

{ #category : #initialization }
ToCheckableNodeManager >> unbindNode: aNode [

	aNode isFake ifFalse: [
		  aNode content unregisterFromGroup ].
	aNode holder contentElement removeFromParent.
	super unbindNode: aNode
]
