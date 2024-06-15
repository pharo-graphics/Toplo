Class {
	#name : #ToCheckableBarEventHandler,
	#superclass : #ToListElementEventHandler,
	#category : #'Toplo-Widget-CheckableBar'
}

{ #category : #initialization }
ToCheckableBarEventHandler >> checkableGroupChangedEvent: anEvent [

	| target checkList uncheckedList |
	target := anEvent currentTarget.
	checkList := anEvent checkedList.
	uncheckedList := anEvent uncheckedList.
	'checked ' traceCr.
	checkList do: [ :n | n traceCr ].
	'unchecked ' traceCr.
	uncheckedList do: [ :n | n traceCr ]
	"
	target isChecked
		ifTrue: [
			target holder checkableBarElement selecter selectIndex:
				target holder position ]
		ifFalse: [
			target holder checkableBarElement selecter deselectIndex:
				target holder position ]"
]

{ #category : #'api - accessing' }
ToCheckableBarEventHandler >> eventsToHandle [

	^ super eventsToHandle, { ToCheckableGroupChangedEvent }

]
