Trait {
	#name : #TToSegmentContentElement,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'t - segment content element' }
TToSegmentContentElement >> checkableBarElement [

	^ self segmentHolder checkableBarElement
]

{ #category : #'t - segment content element' }
TToSegmentContentElement >> positionInSegmentedElement [

	^ self segmentHolder position
]

{ #category : #'t - segment content element' }
TToSegmentContentElement >> segmentHolder [

	^ self parent holder
]
