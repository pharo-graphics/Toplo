Class {
	#name : #ToSegmentedBarEventHandler,
	#superclass : #ToBarElementEventHandler,
	#category : #'Toplo-Widget-Segmented-Bar'
}

{ #category : #'event handling' }
ToSegmentedBarEventHandler >> checkableGroupChangedEvent: anEvent [

	| target checkList uncheckedList |
	target := anEvent currentTarget.
	checkList := anEvent checkedList.
	uncheckedList := anEvent uncheckedList.
	target dataAccessor withIndexDo: [ :e :idx |
		e isChecked
			ifTrue: [ target selecter selectIndex: idx ]
			ifFalse: [ target selecter deselectIndex: idx ] ].

]

{ #category : #'api - accessing' }
ToSegmentedBarEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToCheckableGroupChangedEvent }
]
