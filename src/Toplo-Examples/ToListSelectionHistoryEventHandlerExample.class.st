Class {
	#name : #ToListSelectionHistoryEventHandlerExample,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'historyList'
	],
	#category : #'Toplo-Examples'
}

{ #category : #'api - accessing' }
ToListSelectionHistoryEventHandlerExample >> eventsToHandle [

	^ { ToListSelectionActionEvent }
]

{ #category : #accessing }
ToListSelectionHistoryEventHandlerExample >> historyList [

	^ historyList
]

{ #category : #accessing }
ToListSelectionHistoryEventHandlerExample >> historyList: aList [

	historyList := aList
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listDeselectAllEvent: anEvent [

	historyList data removeAll
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listDeselectIndexEvent: anEvent [

	(historyList data includes: (anEvent currentTarget data at: anEvent index)) ifFalse: [ ^ self ].
	historyList data remove: (anEvent currentTarget data at: anEvent index)
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listMoveSelectedIndexesEvent: anEvent [
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listRemoveSelectedIndexesEvent: anEvent [
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listSelectAllEvent: anEvent [

	historyList data add: anEvent currentTarget data last
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listSelectFromToIndexEvent: anEvent [

	historyList data add: (anEvent currentTarget data at: anEvent interval last)
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listSelectIndexEvent: anEvent [

	historyList data add: (anEvent currentTarget data at: anEvent index)
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listSelectIndexOnlyEvent: anEvent [

	historyList data removeAll.
	historyList data add: (anEvent currentTarget data at: anEvent index)
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listSelectIndexesEvent: anEvent [

	historyList data add:
		(anEvent currentTarget data at: anEvent indexes last)
]
