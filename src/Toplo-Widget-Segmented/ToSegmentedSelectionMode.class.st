Class {
	#name : #ToSegmentedSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #accessing }
ToSegmentedSelectionMode >> deselectOnMouseDown [

	^ false
]

{ #category : #initialization }
ToSegmentedSelectionMode >> initialize [

	super initialize.
	selectionElementOption := ToListSelectionElementOption new.
	selectionElementOption
		grouped: true;
		beneath: true;
		triggerSelectionState: true;
		elementFactory: [ ToListBasicSelectionElement new defaultSkin: ToListPrimarySelectionElementSkin new]
]

{ #category : #'instance creation' }
ToSegmentedSelectionMode >> newSelecter [

	^ ToPrimarySelecter new
]

{ #category : #'instance creation' }
ToSegmentedSelectionMode >> newSelectionChangedEventHandler [ 

	^ ToListPrimarySelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToSegmentedSelectionMode >> newSelectionModel [

	^ ToPrimarySelectionModel new
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

{ #category : #initialization }
ToSegmentedSelectionMode >> selectionElementOption [

	^ ToListSelectionElementOption new
		  grouped: false;
		  beneath: true;
		  triggerSelectionState: true;
		  elementFactory: [
			  ToListBasicSelectionElement new defaultSkin:
					  ToListPrimarySelectionElementSkin new ]
]
