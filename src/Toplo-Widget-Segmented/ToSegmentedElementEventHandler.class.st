Class {
	#name : #ToSegmentedElementEventHandler,
	#superclass : #ToBarElementEventHandler,
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #'event handling' }
ToSegmentedElementEventHandler >> checkableGroupChangedEvent: anEvent [

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
ToSegmentedElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToCheckableGroupChangedEvent }
]
