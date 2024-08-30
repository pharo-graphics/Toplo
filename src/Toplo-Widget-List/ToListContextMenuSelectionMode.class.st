Class {
	#name : #ToListContextMenuSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListContextMenuSelectionMode >> defaultElementBuilder [ 

	^ [ ToListContextMenuSelectionElement new ]
]

{ #category : #initialization }
ToListContextMenuSelectionMode >> defaultOption [

	^ (ToListSelectionOption grouped)
		  beneath: false;
		  yourself
]

{ #category : #initialization }
ToListContextMenuSelectionMode >> listEventHandlerClass [

	^ ToListContextMenuSelectionElementEventHandler 
]

{ #category : #'instance creation' }
ToListContextMenuSelectionMode >> newListEventHandler [

	^ ToListContextMenuSelectionElementEventHandler new 
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
