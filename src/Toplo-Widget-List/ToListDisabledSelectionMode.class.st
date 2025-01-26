Class {
	#name : #ToListDisabledSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListDisabledSelectionMode >> isDisabled [ 

	^ true
]

{ #category : #'instance creation' }
ToListDisabledSelectionMode >> newSelectionChangedEventHandler [

	^ ToListDisabledSelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToListDisabledSelectionMode >> selectionChangedEventClass [ 

	^ ToListDisabledSelectionChangedEvent
]
