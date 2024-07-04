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

	| touchedIndexes target  |
	touchedIndexes := anEvent touchedIndexes.
	target := anEvent currentTarget.
	self refreshSelectionFromEvent: anEvent.
	target notifyDataSourceChanged
]
