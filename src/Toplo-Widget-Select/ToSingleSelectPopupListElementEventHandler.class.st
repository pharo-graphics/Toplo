Class {
	#name : #ToSingleSelectPopupListElementEventHandler,
	#superclass : #ToSelectPopupListElementEventHandler,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #'event handling' }
ToSingleSelectPopupListElementEventHandler >> sieveSelectionChangedEvent: anEvent [

	| listElement selectElement changedEvent selectedIndex |
	super sieveSelectionChangedEvent: anEvent.
	listElement := anEvent currentTarget.
	selectElement := listElement selectElement.
	selectedIndex := selectElement selecter selectedIndex.
	
	changedEvent := ToSelectChangedEvent new.
	changedEvent selectedData: selectElement selectedDataItem.
	changedEvent selectedIndex: selectedIndex.
	selectElement dispatchEvent: changedEvent
]
