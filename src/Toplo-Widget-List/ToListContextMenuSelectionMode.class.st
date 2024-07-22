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
		elementFactory: [ ToListContextMenuSelectionElement new ];
		listEventHandler: ToListContextMenuSelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToListContextMenuSelectionMode >> newSelecter [

	^ super newSelecter
		  selectionChangedEventClass: self selectionChangedEventClass;
		  yourself
]

{ #category : #'instance creation' }
ToListContextMenuSelectionMode >> selectionChangedEventClass [ 

	^ ToListContextMenuSelectionChangedEvent
]

{ #category : #accessing }
ToListContextMenuSelectionMode >> uniqueId [ 

	^ #contextMenu
]
