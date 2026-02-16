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
	listElement useCheckbox ifFalse: [ ^ self ].
	listElement requestUpdateCheckboxes
]
