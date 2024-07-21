Class {
	#name : #ToSegmentedSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'instance creation' }
ToSegmentedSelectionMode >> newSelecter [

	^ super newSelecter
		  selectionChangedEventClass: self selectionChangedEventClass;
		  yourself
]

{ #category : #'instance creation' }
ToSegmentedSelectionMode >> newSelectionModelIn: aListElement [

	^ aListElement newPrimarySelectionModel
]

{ #category : #accessing }
ToSegmentedSelectionMode >> onAddedNode: aNode [
]

{ #category : #accessing }
ToSegmentedSelectionMode >> onRemovedNode: aNode [
]

{ #category : #'instance creation' }
ToSegmentedSelectionMode >> selectionChangedEventClass [ 

	^ ToListPrimarySelectionChangedEvent
]
