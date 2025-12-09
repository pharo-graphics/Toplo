Class {
	#name : #ToSelectPopupListGroupSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #'instance creation' }
ToSelectPopupListGroupSelectionMode >> selectionChangedEventClass [ 

	^ ToSelectGroupSelectionChangedEvent
]
