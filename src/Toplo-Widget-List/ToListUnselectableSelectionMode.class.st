Class {
	#name : #ToListUnselectableSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListUnselectableSelectionMode >> selectionChangedEventClass [ 

	^ ToListUnselectableSelectionChangedEvent
]

{ #category : #accessing }
ToListUnselectableSelectionMode >> uniqueId [ 

	^ #unselectable
]
