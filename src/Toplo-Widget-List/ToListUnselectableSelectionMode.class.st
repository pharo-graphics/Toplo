Class {
	#name : #ToListUnselectableSelectionMode,
	#superclass : #ToListSubSelectionMode,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListUnselectableSelectionMode >> defaultSelectionOption [

	^ super defaultSelectionOption
		  selectionSkinEventClass: ToUnselectableSkinEvent;
		  deselectionSkinEventClass: ToSelectableSkinEvent;
		  yourself
]

{ #category : #testing }
ToListUnselectableSelectionMode >> isUnselectable [ 

	^ true
]

{ #category : #'instance creation' }
ToListUnselectableSelectionMode >> newSelectionChangedEventHandler [ 

	^ ToListUnselectableSelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToListUnselectableSelectionMode >> selectionChangedEventClass [ 

	^ ToListUnselectableSelectionChangedEvent
]
