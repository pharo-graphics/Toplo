Class {
	#name : #ToListDisabledSelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'api - accessing' }
ToListDisabledSelectionElementEventHandler >> eventsToHandle [ 

	^ super eventsToHandle, { ToListDisabledSelectionChangedEvent }
]

{ #category : #'infinite event handling' }
ToListDisabledSelectionElementEventHandler >> listDisabledSelectionChangedEvent: anEvent [

	| touchedIndexes target nodes |
	touchedIndexes := anEvent touchedIndexes.
	target := anEvent currentTarget.
	self refreshSelectionFromEvent: anEvent.
	nodes := target nodes.
	target notifyDataSourceChanged
]
