Class {
	#name : #ToMultiSelectListElementEventHandler,
	#superclass : #ToSelectListElementEventHandler,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'api - accessing' }
ToMultiSelectListElementEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { ToSelectGroupSelectionChangedEvent }
]

{ #category : #'event handling' }
ToMultiSelectListElementEventHandler >> selectGroupSelectionChangedEvent: anEvent [

	| touchedIntervals target |
	touchedIntervals := anEvent touchedIntervals.
	target := anEvent currentTarget.
	touchedIntervals do: [ :int |
		target disabledSelecter selectIndex: int first to: int last.
		self flag: 'Given that the list is initialized with #makeDisabledUnselectable: true, having to unselect here is not desired. It is necessary here because instead, the secondary selection can be on a group index.'.
		target unselectableSelecter selectIndex: int first to: int last.
		target dataSource notifyItemsChanged: int ]
]
