Class {
	#name : #ToListHiddenSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListHiddenSelectionMode >> newSelectionChangedEventHandler [

	^ ToListBasicAdditionalSelectionElementEventHandler new
		  selectionChangedEventClass: self selectionChangedEventClass;
		  yourself
]

{ #category : #'instance creation' }
ToListHiddenSelectionMode >> selectionChangedEventClass [ 

	^ ToListHiddenSelectionChangedEvent
]
