Class {
	#name : #ToListDisabledSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'api - hooks' }
ToListDisabledSelectionMode >> defaultOption [

	^ (ToListSelectionOption separateForMode: self)
		  beneath: false;
		  yourself
]

{ #category : #initialization }
ToListDisabledSelectionMode >> listEventHandlerClass [

	^ ToListDisabledSelectionElementEventHandler 
]

{ #category : #initialization }
ToListDisabledSelectionMode >> selectionChangedEventClass [ 

	^ ToListDisabledSelectionChangedEvent
]

{ #category : #accessing }
ToListDisabledSelectionMode >> uniqueId [ 

	^ #disabled
]
