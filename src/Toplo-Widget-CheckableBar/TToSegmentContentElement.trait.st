Trait {
	#name : #TToSegmentContentElement,
	#category : #'Toplo-Widget-CheckableBar'
}

{ #category : #'t - segment content element' }
TToSegmentContentElement >> positionInSegmentedElement [

	^ self segmentHolder position
]

{ #category : #'t - segment content element' }
TToSegmentContentElement >> segmentHolder [

	^ self parent holder
]

{ #category : #'t - segment content element' }
TToSegmentContentElement >> segmentedElement [

	^ self segmentHolder segmentedElement
]
