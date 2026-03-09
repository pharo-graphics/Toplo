Class {
	#name : #ToSelectPopupListGroupSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-Select'
}

{ #category : #'instance creation' }
ToSelectPopupListGroupSelectionMode >> selectionChangedEventClass [ 

	^ ToSelectGroupSelectionChangedEvent
]
