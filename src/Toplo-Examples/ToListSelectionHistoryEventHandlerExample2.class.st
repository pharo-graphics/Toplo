Class {
	#name : #ToListSelectionHistoryEventHandlerExample2,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'historyList',
		'currentTarget'
	],
	#category : #'Toplo-Examples'
}

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample2 >> addIndexesSelectionCommand: aCommand [ 

	historyList data add:	(currentTarget data at: aCommand indexes last)
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample2 >> addIntervalSelectionCommand: aCommand [

	| s |
	s := currentTarget data at: aCommand to.
	(historyList data includes: s) ifTrue: [ historyList data remove: s ].
	historyList data add: s
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample2 >> addWholeSelectionCommand: aCommand [

	(historyList data includes: currentTarget data last) ifTrue: [ ^ self ].
	historyList data add: currentTarget data last
]

{ #category : #'api - accessing' }
ToListSelectionHistoryEventHandlerExample2 >> eventsToHandle [

	^ { ToSelectionResultEvent }
]

{ #category : #accessing }
ToListSelectionHistoryEventHandlerExample2 >> historyList [

	^ historyList
]

{ #category : #accessing }
ToListSelectionHistoryEventHandlerExample2 >> historyList: aList [

	historyList := aList
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample2 >> removeIndexesSelectionCommand: aCommand [


]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample2 >> removeIntervalSelectionCommand: aCommand [

	(historyList data includes:
		 (currentTarget data at: aCommand to)) ifFalse: [ ^ self ].
	historyList data remove:
		(currentTarget data at: aCommand to)
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample2 >> removeWholeSelectionCommand: aCommand [

	historyList data removeAll
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample2 >> selectionResultEvent: anEvent [

	currentTarget := anEvent currentTarget.
	anEvent command applyOn: self.
	currentTarget := nil
]
