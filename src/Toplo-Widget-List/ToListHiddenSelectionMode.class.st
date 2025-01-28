Class {
	#name : #ToListHiddenSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListHiddenSelectionMode >> isHidden [ 

	^ true
]

{ #category : #'instance creation' }
ToListHiddenSelectionMode >> selectionChangedEventClass [ 

	^ ToListHiddenSelectionChangedEvent
]
