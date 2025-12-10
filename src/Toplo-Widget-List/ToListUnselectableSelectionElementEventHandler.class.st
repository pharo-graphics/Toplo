Class {
	#name : #ToListUnselectableSelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'api - accessing' }
ToListUnselectableSelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToListUnselectableSelectionChangedEvent  }
]

{ #category : #'element handlers' }
ToListUnselectableSelectionElementEventHandler >> listUnselectableSelectionChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self updateSelectionFromEvent: anEvent.
	" have to postpone to avoid having a datasource change during the layout "
	target postponeAction: [ 
		anEvent touchedIntervals do: [ :int | target dataSource notifyItemsChanged: int ] ].
	target secondarySelecter deselectAll
]
