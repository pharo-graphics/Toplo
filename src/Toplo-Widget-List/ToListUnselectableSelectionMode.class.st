Class {
	#name : #ToListUnselectableSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListUnselectableSelectionMode >> isUnselectable [ 

	^ true
]

{ #category : #'instance creation' }
ToListUnselectableSelectionMode >> newSelectionChangedEventHandler [ 

	^ ToListUnselectableSelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToListUnselectableSelectionMode >> selectionChangedEventClass [ 

	^ ToListUnselectableSelectionChangedEvent
]
