Class {
	#name : #ToSegmentedSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #testing }
ToSegmentedSelectionMode >> isMultipleSelection [
	
	^ true
]

{ #category : #'instance creation' }
ToSegmentedSelectionMode >> listEventHandlerClass [

	^ ToListPrimarySelectionElementEventHandler 
]

{ #category : #'instance creation' }
ToSegmentedSelectionMode >> newSelecter [

	^ ToListSelecter new
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
