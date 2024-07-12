Class {
	#name : #ToSegmentedSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'instance creation' }
ToSegmentedSelectionMode >> listEventHandlerClass [

	^ ToListPrimarySelectionElementEventHandler 
]

{ #category : #'instance creation' }
ToSegmentedSelectionMode >> newListEventHandler [

	^ ToListPrimarySelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToSegmentedSelectionMode >> newSelecter [

	^ super newSelecter
		  selectionChangedEventClass: self selectionChangedEventClass;
		  yourself
]

{ #category : #'instance creation' }
ToSegmentedSelectionMode >> newSelectionModel [

	^ listElement newPrimarySelectionModel
]

{ #category : #'instance creation' }
ToSegmentedSelectionMode >> selectionChangedEventClass [ 

	^ ToListPrimarySelectionChangedEvent
]
