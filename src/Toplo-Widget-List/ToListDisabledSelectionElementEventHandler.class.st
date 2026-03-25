Class {
	#name : #ToListDisabledSelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#instVars : [
		'postponeCommand',
		'touchedIndexes'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'api - accessing' }
ToListDisabledSelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToListDisabledSelectionChangedEvent }
]

{ #category : #nil }
ToListDisabledSelectionElementEventHandler >> initialize [ 

	super initialize.
	touchedIndexes := OrderedCollection new
]

{ #category : #'element handlers' }
ToListDisabledSelectionElementEventHandler >> listDisabledSelectionChangedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	self updateSelectionFromEvent: anEvent.
	anEvent selectionModel selectedIndexesIntervalsDo: [ :int |
			listElement selectionMode makeDisabledUnselectable ifTrue: [
				listElement selecter deselectInterval: int ] ].

	touchedIndexes addAll: anEvent appliedCommand indexes.
	postponeCommand ifNotNil: [ ^ self ].
	postponeCommand := ToListDataSourceActionCommand new.
	postponeCommand action: [
			touchedIndexes do: [ :idx |
					(listElement layoutPositionsRange includes: idx) ifTrue: [
						listElement dataSource notifyItemsChanged: (idx to: idx) ] ].
			listElement requestUpdateSelectionMode:
				listElement primarySelectionMode.
			postponeCommand := nil.
			touchedIndexes reset ].
	listElement postponeCommand: postponeCommand
]
