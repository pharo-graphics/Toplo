Class {
	#name : #ToMultiSelectListElementEventHandler,
	#superclass : #ToSelectListElementEventHandler,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'api - accessing' }
ToMultiSelectListElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  ToListPrimarySelectionChangedEvent.
		  ToListSelecterCommandApplicationRequestEvent.
		  ToSelectGroupSelectionChangedEvent }
]

{ #category : #'event handling' }
ToMultiSelectListElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	| listElement selectElement selectedDataItems changedEvent |
	listElement := anEvent currentTarget.
	selectElement := listElement selectElement.
	selectElement refreshHeaderFromPopupListSelection.
	selectedDataItems := selectElement selectionModel
		                     selectedIndexesCollect: [ :idx |
		                     selectElement sieve originalData at: idx ].
	changedEvent := ToSelectChangedEvent new.
	changedEvent selectedDataItems: selectedDataItems.
	changedEvent selectedIndexes:
		selectElement selectionModel selectedIndexes.
	selectElement dispatchEvent: changedEvent
]

{ #category : #'event handling' }
ToMultiSelectListElementEventHandler >> listSelecterCommandApplicationRequestEvent: anEvent [

	| listElement select |
	listElement := anEvent currentTarget.
	anEvent selectionModel = listElement selectionModel ifFalse: [ ^ self ].
	listElement selectionModel selectedIndexesCount > 0 ifFalse: [ ^ self ].
	select := listElement selectElement.
	select checkMaxSelectedCount 
]

{ #category : #'event handling' }
ToMultiSelectListElementEventHandler >> selectGroupSelectionChangedEvent: anEvent [

	| touchedIntervals listElement |
	touchedIntervals := anEvent touchedIntervals.
	listElement := anEvent currentTarget.
	touchedIntervals do: [ :int |
		listElement disabledSelecter selectIndex: int first to: int last.
		self flag: 'Given that the list is initialized with #makeDisabledUnselectable: true, having to unselect here is not desired. It is necessary here because instead, the secondary selection can be on a group index.'.
		listElement unselectableSelecter selectIndex: int first to: int last.
		listElement dataSource notifyItemsChanged: int ]
]
