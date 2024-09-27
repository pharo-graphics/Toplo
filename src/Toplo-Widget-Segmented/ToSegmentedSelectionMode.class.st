Class {
	#name : #ToSegmentedSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #accessing }
ToSegmentedSelectionMode >> deselectOnMouseDown [

	^ false
]

{ #category : #initialization }
ToSegmentedSelectionMode >> initialize [

	super initialize.
	option := ToListSelectionElementOption new.
	option
		grouped: true;
		beneath: true;
		triggerSelectionState: true;
		elementFactory: [ ToListBasicSelectionElement new defaultSkin: ToListPrimarySelectionElementSkin new];
		listEventHandler: ToListPrimarySelectionElementEventHandler new
]

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
