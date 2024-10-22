Class {
	#name : #ToListUnselectableSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListUnselectableSelectionMode >> newSelectionChangedEventHandler [ 

	^ ToListUnselectableSelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToListUnselectableSelectionMode >> selectionChangedEventClass [ 

	^ ToListUnselectableSelectionChangedEvent
]
