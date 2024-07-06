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

	| touchedIntervals target  |
	touchedIntervals := anEvent touchedIntervals.
	target := anEvent currentTarget.
	self refreshSelectionFromEvent: anEvent.
	'listDisabledSelectionChangedEvent: ' trace. anEvent touchedIntervals traceCr.
	touchedIntervals do: [ :int |
		target dataSource notifyItemsChanged: int ]
]
