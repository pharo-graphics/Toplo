Class {
	#name : #ToListDisabledSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListDisabledSelectionMode >> listEventHandlerClass [

	^ ToListDisabledSelectionElementEventHandler 
]

{ #category : #'instance creation' }
ToListDisabledSelectionMode >> newListEventHandler [

	^ ToListDisabledSelectionElementEventHandler new
]

{ #category : #initialization }
ToListDisabledSelectionMode >> selectionChangedEventClass [ 

	^ ToListDisabledSelectionChangedEvent
]

{ #category : #accessing }
ToListDisabledSelectionMode >> uniqueId [ 

	^ #disabled
]
