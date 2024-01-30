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

	^ { ToListSelectionActionEventDep }
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
ToListSelectionHistoryEventHandlerExample >> listRemoveSelectedIndexesEvent: anEvent [
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listSelectAllEvent: anEvent [

	historyList data add: anEvent currentTarget data last
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listSelectFromToIndexEvent: anEvent [

	| s |
	s := anEvent currentTarget data at: anEvent interval last.
	(historyList data includes: s) ifTrue: [ historyList data remove: s ].
	historyList data add: (s)
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listSelectIndexEvent: anEvent [

	| s |
	s := anEvent currentTarget data at: anEvent index.
	(historyList data includes: s) ifTrue: [ historyList data remove: s ].
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

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listShiftSelectionEvent: anEvent [
]
