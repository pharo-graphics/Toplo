Class {
	#name : #ToCheckableBarElementEventHandler,
	#superclass : #ToListElementEventHandler,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'event handling' }
ToCheckableBarElementEventHandler >> checkableGroupChangedEvent: anEvent [

	| currTarget checkList uncheckedList |
	currTarget := anEvent currentTarget.
	checkList := anEvent checkedList.
	uncheckedList := anEvent uncheckedList.
	currTarget dataAccessor withIndexDo: [ :e :idx |
		e isChecked
			ifTrue: [ currTarget selecter selectIndex: idx ]
			ifFalse: [ currTarget selecter deselectIndex: idx ] ].

]

{ #category : #'api - accessing' }
ToCheckableBarElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToCheckableGroupChangedEvent }
]
