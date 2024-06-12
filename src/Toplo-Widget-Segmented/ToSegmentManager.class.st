Class {
	#name : #ToSegmentManager,
	#superclass : #ToBarNodeManager,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'instance creation' }
ToSegmentManager >> buildFakeNode: aFakeNode inHolder: anHolder [

	anHolder dataItem:
		(ToLabeledIcon new labelText: self fakeDataItem asString).
	super buildFakeNode: aFakeNode inHolder: anHolder
]

{ #category : #initialization }
ToSegmentManager >> constraintNode: aSegment [

	super constraintNode: aSegment
	"aSegment constraintsDo: [ :c |
		c vertical fitContent.
		aSegment holder segmentedElement isHorizontal
			ifTrue: [ c horizontal fitContent ]
			ifFalse: [ c horizontal matchParent ] ]"
]

{ #category : #initialization }
ToSegmentManager >> defaultNodeBuilder [

	^ [ :segment :holder :element | segment isFake ifFalse: [segment registerInGroup: holder segmentedElement group].
	  segment addChild: element ]
]

{ #category : #initialization }
ToSegmentManager >> defaultNodeFactory [

	^ [ :holder |
	  ToSegment new ]
]

{ #category : #initialization }
ToSegmentManager >> defaultNodeHolderClass [

	^ ToSegmentHolder
]

{ #category : #initialization }
ToSegmentManager >> unbindNode: aNode [

	aNode holder dataItem removeFromParent
]
