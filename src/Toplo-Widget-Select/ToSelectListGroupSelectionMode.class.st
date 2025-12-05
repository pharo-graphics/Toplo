Class {
	#name : #ToSelectListGroupSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #'instance creation' }
ToSelectListGroupSelectionMode >> selectionChangedEventClass [ 

	^ ToSelectGroupSelectionChangedEvent
]
