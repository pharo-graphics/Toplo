Class {
	#name : #ToListContextMenuSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

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
