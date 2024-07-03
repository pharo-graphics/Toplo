Class {
	#name : #ToSegmentedEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #initialization }
ToSegmentedEventHandler >> checkableGroupChangedEvent: anEvent [

	| target checkList uncheckedList |
	target := anEvent currentTarget.
	checkList := anEvent checkedList.
	uncheckedList := anEvent uncheckedList.
	target segmentAccessor withIndexDo: [ :e :idx |
		e isChecked
			ifTrue: [ target selecter selectIndex: idx ]
			ifFalse: [ target selecter deselectIndex: idx ] ].

]

{ #category : #'api - accessing' }
ToSegmentedEventHandler >> eventsToHandle [

	^ { ToCheckableGroupChangedEvent }

]
