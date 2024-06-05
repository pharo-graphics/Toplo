Class {
	#name : #ToSegmentManager,
	#superclass : #ToBarNodeManager,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #initialization }
ToSegmentManager >> defaultNodeBuilder [

	^ [ :segment :holder :element |
	  element removeFromParent.
	  element constraintsDo: [ :c | c horizontal matchParent ].
	  segment addChild: element.
	  segment constraintsDo: [ :c |
		  c horizontal fitContent.
		  c vertical fitContent ] ]
]

{ #category : #initialization }
ToSegmentManager >> defaultNodeFactory [

	^ [ :holder | ToSegment new ]
]

{ #category : #initialization }
ToSegmentManager >> defaultNodeHolderClass [

	^ ToSegmentHolder
]

{ #category : #accessing }
ToSegmentManager >> fakeElement: anElement [
	
	self fakeDataItem: anElement
]

{ #category : #'instance creation' }
ToSegmentManager >> newFakeNodeForHolder: anHolder [

	anHolder dataItem: (ToLabeledIcon new labelText: self fakeDataItem asString).
	^ super newFakeNodeForHolder: anHolder

]
