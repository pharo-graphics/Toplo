Class {
	#name : #ToListContextMenuSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

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
		  selectionModel: ToSelectionModel new;
		  selectionChangedEventClass: self selectionChangedEventClass;
		  yourself
]

{ #category : #'instance creation' }
ToListContextMenuSelectionMode >> newSelectionChangeEventHandler [

	^ ToListContextMenuSelectionElementEventHandler new
]

{ #category : #initialization }
ToListContextMenuSelectionMode >> on: aListElement [

	super on: aListElement.
	aListElement addEventHandler: self newSelectionChangeEventHandler 
]

{ #category : #'instance creation' }
ToListContextMenuSelectionMode >> selectionChangedEventClass [ 

	^ ToListContextMenuSelectionChangedEvent
]
