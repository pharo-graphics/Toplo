Class {
	#name : #ToListDisabledSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListDisabledSelectionMode >> selectionChangedEventClass [ 

	^ ToListDisabledSelectionChangedEvent
]

{ #category : #accessing }
ToListDisabledSelectionMode >> uniqueId [ 

	^ #disabled
]
