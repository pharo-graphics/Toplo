Class {
	#name : #ToCheckableListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'api - accessing' }
ToCheckableListElementEventHandler >> eventsToHandle [

	^ { ToListPrimarySelectionChangedEvent }
]

{ #category : #'event handling' }
ToCheckableListElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.

	listElement dataAccessor do: [ :checkable |
			checkable privateChecked:
				(listElement selectionModel containsIndex:
					 checkable holder position) ]
]
