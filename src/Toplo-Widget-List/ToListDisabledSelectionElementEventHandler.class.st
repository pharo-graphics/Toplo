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

	| touchedIntervals target |
	touchedIntervals := anEvent touchedIntervals.
	target := anEvent currentTarget.
	self updateSelectionFromEvent: anEvent.
	target nodesDo: [ :aNode |
		| holder |
		holder := aNode holder.
		holder shouldIgnore ifFalse: [
			holder initializeNode ] ].
]
