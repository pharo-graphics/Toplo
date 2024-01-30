Class {
	#name : #ToListSelectionHistoryEventHandlerExample,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'historyList',
		'currentTarget'
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

{ #category : #'event handling deprecated' }
ToListSelectionHistoryEventHandlerExample >> listDeselectAllEvent: anEvent [

	historyList data removeAll
]

{ #category : #'event handling deprecated' }
ToListSelectionHistoryEventHandlerExample >> listDeselectIndexEvent: anEvent [

	(historyList data includes: (anEvent currentTarget data at: anEvent index)) ifFalse: [ ^ self ].
	historyList data remove: (anEvent currentTarget data at: anEvent index)
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listExplicitSelectionAction: aSelectionAction [

	aSelectionAction isSelection ifFalse: [ ^ self ].
	historyList data add:
		(currentTarget data at: aSelectionAction indexes last)
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listIntervalSelectionAction: aSelectionAction [

	| s |
	aSelectionAction isSelection ifFalse: [
		(historyList data includes:
			 (currentTarget data at: aSelectionAction interval last)) ifFalse: [
			^ self ].
		historyList data remove:
			(currentTarget data at: aSelectionAction interval last).
		^ self ].
	s := currentTarget data at: aSelectionAction interval last.
	(historyList data includes: s) ifTrue: [ historyList data remove: s ].
	historyList data add: s
]

{ #category : #'event handling deprecated' }
ToListSelectionHistoryEventHandlerExample >> listRemoveSelectedIndexesEvent: anEvent [
]

{ #category : #'event handling deprecated' }
ToListSelectionHistoryEventHandlerExample >> listSelectAllEvent: anEvent [

	historyList data add: anEvent currentTarget data last
]

{ #category : #'event handling deprecated' }
ToListSelectionHistoryEventHandlerExample >> listSelectFromToIndexEvent: anEvent [

	| s |
	s := anEvent currentTarget data at: anEvent interval last.
	(historyList data includes: s) ifTrue: [ historyList data remove: s ].
	historyList data add: (s)
]

{ #category : #'event handling deprecated' }
ToListSelectionHistoryEventHandlerExample >> listSelectIndexEvent: anEvent [

	| s |
	s := anEvent currentTarget data at: anEvent index.
	(historyList data includes: s) ifTrue: [ historyList data remove: s ].
	historyList data add: (anEvent currentTarget data at: anEvent index)
]

{ #category : #'event handling deprecated' }
ToListSelectionHistoryEventHandlerExample >> listSelectIndexOnlyEvent: anEvent [

	historyList data removeAll.
	historyList data add: (anEvent currentTarget data at: anEvent index)
]

{ #category : #'event handling deprecated' }
ToListSelectionHistoryEventHandlerExample >> listSelectIndexesEvent: anEvent [

	historyList data add:
		(anEvent currentTarget data at: anEvent indexes last)
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listSelectionActionEvent: anEvent [

	currentTarget := anEvent currentTarget.
	anEvent action applyOn: self.
	currentTarget := nil
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listShiftSelectionAction: aSelectionAction [

	" nothing to do "
]

{ #category : #'event handling deprecated' }
ToListSelectionHistoryEventHandlerExample >> listShiftSelectionEvent: anEvent [
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listWholeDataSelectionAction: aSelectionAction [

	aSelectionAction isDeselection ifTrue: [
		historyList data removeAll.
		^ self ].
	historyList data add: currentTarget data last
]
