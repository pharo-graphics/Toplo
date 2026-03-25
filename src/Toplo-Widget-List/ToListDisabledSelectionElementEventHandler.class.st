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

	| listElement |
	listElement := anEvent currentTarget.
	self updateSelectionFromEvent: anEvent.
	anEvent selectionModel selectedIndexesIntervalsDo: [ :int |
			listElement selectionMode makeDisabledUnselectable ifTrue: [
				listElement selecter deselectInterval: int ] ].

	listElement postponeAction: [
			anEvent appliedCommand indexes do: [ :idx |
					(listElement layoutPositionsRange includes: idx) ifTrue: [
						listElement dataSource notifyItemsChanged: (idx to: idx) ] ].
			listElement requestUpdateSelectionMode:
				listElement primarySelectionMode ]
]
