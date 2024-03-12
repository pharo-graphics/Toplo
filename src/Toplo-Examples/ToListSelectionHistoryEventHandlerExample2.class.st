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

	aCommand operation deselectAllBefore ifTrue: [
		historyList data removeAll ].
	historyList data add: (currentTarget data at: aCommand indexes last)
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample2 >> addIntervalSelectionCommand: aCommand [

	| s |
	aCommand operation deselectAllBefore ifTrue: [
		historyList dataAccessor removeAll ].
	s := currentTarget dataAccessor at: aCommand to.
	(historyList dataAccessor includes: s) ifTrue: [
		historyList dataAccessor remove: s ].
	historyList dataAccessor add: s
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample2 >> addWholeSelectionCommand: aCommand [

	(historyList dataAccessor includes: currentTarget dataAccessor last)
		ifTrue: [ ^ self ].
	historyList dataAccessor add: currentTarget dataAccessor last
]

{ #category : #'api - accessing' }
ToListSelectionHistoryEventHandlerExample2 >> eventsToHandle [

	^ { ToPrimarySelectionCommandAppliedEvent }
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
ToListSelectionHistoryEventHandlerExample2 >> primarySelectionCommandAppliedEvent: aCommandAppliedEvent [

	currentTarget := aCommandAppliedEvent currentTarget.
	aCommandAppliedEvent command applyOn: self in: self historyList.
	currentTarget := nil
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample2 >> removeIndexesSelectionCommand: aCommand [


]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample2 >> removeIntervalSelectionCommand: aCommand [

	(historyList dataAccessor includes:
		 (currentTarget dataAccessor at: aCommand to)) ifFalse: [ ^ self ].
	historyList dataAccessor remove:
		(currentTarget dataAccessor at: aCommand to)
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample2 >> removeWholeSelectionCommand: aCommand [

	historyList dataAccessor removeAll
]
