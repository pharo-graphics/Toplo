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
	listElement primarySelectionMode dirty: true.
	" have to postpone to avoid having a datasource change during the layout "
	listElement postponeAction: [
			anEvent selectionModel selectedIndexesIntervalsDo: [ :int |
					listElement selectionMode makeDisabledUnselectable ifTrue: [
						listElement selecter deselectInterval: int ].
					listElement useCheckbox ifTrue: [
						listElement dataSource notifyItemsChanged: int ] ] ]
]
