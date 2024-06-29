Trait {
	#name : #TToSegmentedNodeContentElement,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'t - segment content element' }
TToSegmentedNodeContentElement >> positionInSegmentedElement [

	^ self segmentHolder position
]

{ #category : #'t - segment content element' }
TToSegmentedNodeContentElement >> segmentHolder [

	^ self parent holder
]

{ #category : #'t - segment content element' }
TToSegmentedNodeContentElement >> segmentedBarElement [

	^ self segmentHolder segmentedBarElement
]
