Class {
	#name : #ToListSelectionHistoryEventHandlerExample,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'historyList',
		'currentTarget'
	],
	#category : #'Toplo-Examples'
}

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> addIndexesSelectionCommand: aCommand [

	aCommand operation deselectAllBefore ifTrue: [
		historyList data removeAll ].
	historyList data add: (currentTarget data at: aCommand indexes last)
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> addIntervalSelectionCommand: aCommand [

	| s |
	aCommand operation deselectAllBefore ifTrue: [
		historyList dataAccessor removeAll ].
	s := currentTarget dataAccessor at: aCommand to.
	(historyList dataAccessor includes: s) ifTrue: [
		historyList dataAccessor remove: s ].
	historyList dataAccessor add: s
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> addWholeSelectionCommand: aCommand [

	(historyList dataAccessor includes: currentTarget dataAccessor last)
		ifTrue: [ ^ self ].
	historyList dataAccessor add: currentTarget dataAccessor last
]

{ #category : #'api - accessing' }
ToListSelectionHistoryEventHandlerExample >> eventsToHandle [

	^ { ToPrimarySelectionCommandAppliedEvent }
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
ToListSelectionHistoryEventHandlerExample >> primarySelectionCommandAppliedEvent: aCommandAppliedEvent [

	currentTarget := aCommandAppliedEvent currentTarget.
	aCommandAppliedEvent command applyOn: self.
	currentTarget := nil
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> removeIndexesSelectionCommand: aCommand [


]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> removeIntervalSelectionCommand: aCommand [

	(historyList dataAccessor includes:
		 (currentTarget dataAccessor at: aCommand to)) ifFalse: [ ^ self ].
	historyList dataAccessor remove:
		(currentTarget dataAccessor at: aCommand to)
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample >> removeWholeSelectionCommand: aCommand [

	historyList dataAccessor removeAll
]
