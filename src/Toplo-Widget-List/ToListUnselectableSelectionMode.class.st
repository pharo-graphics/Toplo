Class {
	#name : #ToListUnselectableSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListUnselectableSelectionMode >> listEventHandlerClass [

	^ ToListUnselectableSelectionElementEventHandler 
]

{ #category : #'instance creation' }
ToListUnselectableSelectionMode >> newListEventHandler [

	^ ToListUnselectableSelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToListUnselectableSelectionMode >> selectionChangedEventClass [ 

	^ ToListUnselectableSelectionChangedEvent
]

{ #category : #accessing }
ToListUnselectableSelectionMode >> uniqueId [ 

	^ #unselectable
]
