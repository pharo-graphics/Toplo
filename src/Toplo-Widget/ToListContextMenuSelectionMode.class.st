Class {
	#name : #ToListContextMenuSelectionMode,
	#superclass : #ToListRootSelectionMode,
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToListContextMenuSelectionMode >> defaultSelectionOption [

	^ ToListSelectionOption new
		  grouped: true;
		  beneath: false;
		  elementFactory: [ ToListContextMenuSelectionElement new ]
]

{ #category : #'instance creation' }
ToListContextMenuSelectionMode >> newSelecter [

	^ ToSimpleSelecter new
]

{ #category : #'instance creation' }
ToListContextMenuSelectionMode >> newSelectionChangedEventHandler [

	^ ToListContextMenuSelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToListContextMenuSelectionMode >> newSelectionModelIn: aListElement [

	^ ToSelectionModel new
]

{ #category : #'instance creation' }
ToListContextMenuSelectionMode >> selectionChangedEventClass [ 

	^ ToListContextMenuSelectionChangedEvent
]
