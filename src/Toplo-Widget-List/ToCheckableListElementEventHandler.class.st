Class {
	#name : #ToCheckableListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'event handling' }
ToCheckableListElementEventHandler >> checkableGroupChangedEvent: anEvent [

	| currTarget selectedIndexes |
	currTarget := anEvent currentTarget.
	selectedIndexes := Array streamContents: [ :stream |
		                   anEvent checkedList do: [ :e |
			                   stream nextPut: e holder position ] ].
	currTarget selecter selectOnlyIndexes: selectedIndexes
]

{ #category : #'api - accessing' }
ToCheckableListElementEventHandler >> eventsToHandle [

	^ { ToListPrimarySelectionChangedEvent. ToCheckableGroupChangedEvent }
]

{ #category : #'event handling' }
ToCheckableListElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	" check the checkable item element. does nothing if it is already checked "
	anEvent selectedIndexes do: [ :idx |
		(listElement dataAccessor at: idx) checked: true ]
]
