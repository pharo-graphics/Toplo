Class {
	#name : #ToSelectListGroupSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'instance creation' }
ToSelectListGroupSelectionMode >> selectionChangedEventClass [ 

	^ ToSelectGroupSelectionChangedEvent
]
