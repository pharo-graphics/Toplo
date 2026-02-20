Class {
	#name : #ToListDisabledSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListDisabledSelectionMode >> newSelectionChangedEventHandler [

	^ ToListDisabledSelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToListDisabledSelectionMode >> selectionChangedEventClass [ 

	^ ToListDisabledSelectionChangedEvent
]
