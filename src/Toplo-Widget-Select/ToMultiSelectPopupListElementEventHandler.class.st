Class {
	#name : #ToMultiSelectPopupListElementEventHandler,
	#superclass : #ToSelectPopupListElementEventHandler,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #'api - accessing' }
ToMultiSelectPopupListElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToSelectGroupSelectionChangedEvent }
]

{ #category : #'event handling' }
ToMultiSelectPopupListElementEventHandler >> selectGroupSelectionChangedEvent: anEvent [

	|  listElement |
	listElement := anEvent currentTarget.
	listElement selectedIndexesIntervalsDo: [ :int |
		listElement disabledSelecter selectIndex: int first to: int last.
		self flag: 'Given that the list is initialized with #makeDisabledUnselectable: true, having to unselect here is not desired. It is necessary here because instead, the secondary selection can be on a group index.'.
		listElement unselectableSelecter selectIndex: int first to: int last.
		listElement dataSource notifyItemsChanged: int ]
]

{ #category : #'event handling' }
ToMultiSelectPopupListElementEventHandler >> sieveSelectionChangedEvent: anEvent [

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
