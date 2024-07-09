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

	| touchedIndexes target |
	touchedIndexes := anEvent touchedIndexes.
	target := anEvent currentTarget.
	self updateSelectionFromEvent: anEvent.
	target selecter deselectIndexes: touchedIndexes.
	target secondarySelecter deselectAll.
	anEvent touchedIntervals do: [ :int |
		target dataSource notifyItemsChanged: int ]
]
