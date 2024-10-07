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
	option := ToListSelectionElementOption new.
	option
		grouped: true;
		beneath: true;
		triggerSelectionState: true;
		elementFactory: [ ToListBasicSelectionElement new defaultSkin: ToListPrimarySelectionElementSkin new]
]

{ #category : #'instance creation' }
ToSegmentedSelectionMode >> newSelecter [

	^ ToPrimarySelecter new
		  selectionModel: ToPrimarySelectionModel new;
		  selectionChangedEventClass: self selectionChangedEventClass;
		  yourself
]

{ #category : #'instance creation' }
ToSegmentedSelectionMode >> newSelectionChangeEventHandler [ 

	^ ToListPrimarySelectionElementEventHandler new
]

{ #category : #initialization }
ToSegmentedSelectionMode >> on: aListElement [

	super on: aListElement.
	aListElement addEventHandler: self newSelectionChangeEventHandler 
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
