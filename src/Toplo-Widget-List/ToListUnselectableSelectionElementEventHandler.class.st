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
	anEvent touchedIntervals do: [ :int |
		target selecter deselectIndex: int first to: int last ].
	target secondarySelecter deselectAll
]
