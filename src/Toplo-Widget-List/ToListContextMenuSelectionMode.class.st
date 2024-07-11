Class {
	#name : #ToListContextMenuSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListContextMenuSelectionMode >> defaultElementBuilder [ 

	^ [ ToListContextMenuSelectionElement new ]
]

{ #category : #'api - hooks' }
ToListContextMenuSelectionMode >> defaultOption [

	^ (ToListSelectionOption groupedForMode: self)
		  beneath: false;
		  yourself
]

{ #category : #testing }
ToListContextMenuSelectionMode >> isMultipleSelection [

	^ true
]

{ #category : #initialization }
ToListContextMenuSelectionMode >> listEventHandlerClass [

	^ ToListContextMenuSelectionElementEventHandler 
]

{ #category : #'instance creation' }
ToListContextMenuSelectionMode >> newSelecter [

	^ ToListSelecter new
		  selectionChangedEventClass: self selectionChangedEventClass;
		  yourself
]

{ #category : #'api - hooks' }
ToListContextMenuSelectionMode >> newSelectionModel [

	^ listElement newSelectionModel
]

{ #category : #'instance creation' }
ToListContextMenuSelectionMode >> selectionChangedEventClass [ 

	^ ToListContextMenuSelectionChangedEvent
]
