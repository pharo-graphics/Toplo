Class {
	#name : #ToListDisabledSelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#instVars : [
		'touchedIndexes',
		'postponedCommand'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'api - accessing' }
ToListDisabledSelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToListDisabledSelectionChangedEvent }
]

{ #category : #initialization }
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
	postponedCommand ifNotNil: [ ^ self ].
	postponedCommand := ToListDataSourceActionCommand new.
	postponedCommand action: [
			touchedIndexes do: [ :idx |
					(listElement layoutPositionsRange includes: idx) ifTrue: [
						listElement dataSource notifyItemsChanged: (idx to: idx) ] ].
			listElement requestUpdateSelectionMode:
				listElement primarySelectionMode.
			postponedCommand := nil.
			touchedIndexes reset ].
	listElement postponeCommand: postponedCommand
]
