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
	" have to postpone to avoid having a datasource change during the layout "
	target postponeAction: [
			anEvent touchedIntervals do: [ :int |
					target selectionMode makeDisabledUnselectable ifTrue: [
						target selecter deselectInterval: int ].
					target dataSource notifyItemsChanged: int ] ].
	target selectionOption notifyNodesSelectedIn: target
]
