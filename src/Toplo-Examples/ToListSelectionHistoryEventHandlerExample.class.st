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

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> listWholeDataSelectionAction: aSelectionAction [

	aSelectionAction isDeselection ifTrue: [
		historyList data removeAll.
		^ self ].
	(historyList data includes: currentTarget data last) ifTrue: [ ^ self ].
	historyList data add: currentTarget data last
]
