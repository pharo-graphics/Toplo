Class {
	#name : #ToCheckableBarElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #'event handling' }
ToCheckableBarElementEventHandler >> checkableGroupChangedEvent: anEvent [

	| currTarget selectedIndexes |
	currTarget := anEvent currentTarget.
	selectedIndexes := Array streamContents: [ :stream |
		                   anEvent checkedList do: [ :e |
			                   stream nextPut: e holder position ] ].
	currTarget selecter selectOnlyIndexes: selectedIndexes
]

{ #category : #'api - accessing' }
ToCheckableBarElementEventHandler >> eventsToHandle [

	^ { ToListPrimarySelectionChangedEvent. ToCheckableGroupChangedEvent }
]

{ #category : #'event handling' }
ToCheckableBarElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	" check the checkable item element. does nothing if it is already checked "
	anEvent selectedIndexes do: [ :idx |
		(listElement dataAccessor at: idx) checked: true ]
]
