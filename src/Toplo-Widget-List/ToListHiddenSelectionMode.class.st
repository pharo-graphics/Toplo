Class {
	#name : #ToListHiddenSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListHiddenSelectionMode >> selectionChangedEventClass [ 

	^ ToListHiddenSelectionChangedEvent
]

{ #category : #accessing }
ToListHiddenSelectionMode >> uniqueId [ 

	^ #hidden
]
