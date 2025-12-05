Class {
	#name : #ToMultiSelectListElementEventHandler,
	#superclass : #ToSelectListElementEventHandler,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #'api - accessing' }
ToMultiSelectListElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToSelectGroupSelectionChangedEvent }
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

{ #category : #'event handling' }
ToMultiSelectListElementEventHandler >> sieveSelectionChangedEvent: anEvent [

	| listElement selectElement changedEvent |
	super sieveSelectionChangedEvent: anEvent.
	listElement := anEvent currentTarget.
	selectElement := listElement selectElement.
	selectElement checkMaxSelectedCountInPopupList.
	changedEvent := ToSelectChangedEvent new.
	changedEvent selectedDataItems: selectElement selectedDataItems.
	changedEvent selectedIndexes:
		selectElement selectionModel selectedIndexes.
	selectElement dispatchEvent: changedEvent
]
