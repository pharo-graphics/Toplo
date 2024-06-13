Class {
	#name : #ToCheckableNodeManager,
	#superclass : #ToBarNodeManager,
	#category : #'Toplo-Widget-CheckableBar'
}

{ #category : #'instance creation' }
ToCheckableNodeManager >> buildFakeNode: aFakeNode inHolder: anHolder [

	anHolder dataItem:
		(ToLabeledIcon new labelText: self fakeDataItem asString).
	super buildFakeNode: aFakeNode inHolder: anHolder
]

{ #category : #initialization }
ToCheckableNodeManager >> constraintNode: aSegment [

	super constraintNode: aSegment
	"aSegment constraintsDo: [ :c |
		c vertical fitContent.
		aSegment holder segmentedElement isHorizontal
			ifTrue: [ c horizontal fitContent ]
			ifFalse: [ c horizontal matchParent ] ]"
]

{ #category : #initialization }
ToCheckableNodeManager >> defaultNodeBuilder [

	^ [ :segment :holder :element | segment isFake ifFalse: [segment registerInGroup: holder segmentedElement group].
	  segment addChild: element ]
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

	aNode holder dataItem removeFromParent
]
