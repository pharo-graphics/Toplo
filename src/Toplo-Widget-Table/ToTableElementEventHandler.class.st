Class {
	#name : #ToTableElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #'event handling' }
ToTableElementEventHandler >> addedToSpaceEvent: anEvent [

	| table |
	table := anEvent currentTarget.
	table header whenLayoutedDoOnce: [ table recordCellsWidth ]
]

{ #category : #'api - accessing' }
ToTableElementEventHandler >> eventsToHandle [

	^ { ToAddedToSpaceEvent }
]
