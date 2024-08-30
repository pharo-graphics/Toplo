Class {
	#name : #ToListHiddenSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListHiddenSelectionMode >> listEventHandlerClass [

	^ ToListHiddenSelectionElementEventHandler
]

{ #category : #'instance creation' }
ToListHiddenSelectionMode >> newListEventHandler [

	^ ToListHiddenSelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToListHiddenSelectionMode >> selectionChangedEventClass [ 

	^ ToListHiddenSelectionChangedEvent
]

{ #category : #accessing }
ToListHiddenSelectionMode >> uniqueId [ 

	^ #hidden
]
