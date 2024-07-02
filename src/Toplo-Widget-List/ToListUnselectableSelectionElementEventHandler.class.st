Class {
	#name : #ToListUnselectableSelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #accessing }
ToListUnselectableSelectionElementEventHandler class >> selectionMode: aSelectionMode selectionChangedEventClass: anEventClass [

	^ (self selectionMode: aSelectionMode)
		  selectionChangedEventClass: anEventClass;
		  yourself
]

{ #category : #'api - accessing' }
ToListUnselectableSelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToListUnselectableSelectionChangedEvent  }
]

{ #category : #'element handlers' }
ToListUnselectableSelectionElementEventHandler >> listUnselectableSelectionChangedEvent: anEvent [

	| touchedIndexes target nodes |
	touchedIndexes := anEvent touchedIndexes.
	target := anEvent currentTarget.
	self refreshSelectionFromEvent: anEvent.
	nodes := target nodes.
	target selecter deselectIndexes: touchedIndexes.
	target secondarySelecter deselectAll
]
