Class {
	#name : #ToListUnselectableSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'api - hooks' }
ToListUnselectableSelectionMode >> defaultOption [

	^ (ToListSelectionOption separateForMode: self)
		  beneath: false;
		  yourself
]

{ #category : #initialization }
ToListUnselectableSelectionMode >> listEventHandlerClass [

	^ ToListUnselectableSelectionElementEventHandler 
]

{ #category : #'instance creation' }
ToListUnselectableSelectionMode >> selectionChangedEventClass [ 

	^ ToListUnselectableSelectionChangedEvent
]

{ #category : #accessing }
ToListUnselectableSelectionMode >> uniqueId [ 

	^ #unselectable
]
