Class {
	#name : #ToCheckableBarElementEventHandler,
	#superclass : #ToListElementEventHandler,
	#category : #'Toplo-Widget-List-ItemBar'
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

	^ super eventsToHandle , { ToCheckableGroupChangedEvent }
]
