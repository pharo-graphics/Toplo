Class {
	#name : #ToListDisabledSelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'api - accessing' }
ToListDisabledSelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToListDisabledSelectionChangedEvent }
]

{ #category : #'element handlers' }
ToListDisabledSelectionElementEventHandler >> listDisabledSelectionChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	
	self updateSelectionFromEvent: anEvent. 
	anEvent touchedIntervals do: [ :int |
		target dataSource notifyItemsChanged: int ].
	target postponeAction: [
			target selectionOption notifyNodesSelectedIn: target ]
]
