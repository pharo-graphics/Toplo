Class {
	#name : #ToListDisabledSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-List'
}

{ #category : #'instance creation' }
ToListDisabledSelectionMode >> newSelectionChangedEventHandler [

	^ ToListDisabledSelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToListDisabledSelectionMode >> selectionChangedEventClass [ 

	^ ToListDisabledSelectionChangedEvent
]
