Class {
	#name : #ToMultiSelectListElementEventHandler,
	#superclass : #ToSelectListElementEventHandler,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'api - accessing' }
ToMultiSelectListElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  ToListSelecterCommandApplicationRequestEvent.
		  ToSelectGroupSelectionChangedEvent }
]

{ #category : #'event handling' }
ToMultiSelectListElementEventHandler >> listSelecterCommandApplicationRequestEvent: anEvent [

	anEvent deny
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
