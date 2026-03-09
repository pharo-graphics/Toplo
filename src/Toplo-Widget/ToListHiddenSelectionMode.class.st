Class {
	#name : #ToListHiddenSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-List'
}

{ #category : #'instance creation' }
ToListHiddenSelectionMode >> selectionChangedEventClass [ 

	^ ToListHiddenSelectionChangedEvent
]
