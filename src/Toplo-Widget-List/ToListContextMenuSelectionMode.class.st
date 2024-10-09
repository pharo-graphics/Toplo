Class {
	#name : #ToListContextMenuSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListContextMenuSelectionMode >> defaultOption [

	^ ToListSelectionElementOption new
		  grouped: true;
		  beneath: false;
		  elementFactory: [ ToListContextMenuSelectionElement new ]
]

{ #category : #initialization }
ToListContextMenuSelectionMode >> initialize [

	super initialize.
	option := ToListSelectionElementOption new.
	option
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
ToListContextMenuSelectionMode >> newSelectionModel [

	^ ToSelectionModel new
]

{ #category : #'instance creation' }
ToListContextMenuSelectionMode >> selectionChangedEventClass [ 

	^ ToListContextMenuSelectionChangedEvent
]
