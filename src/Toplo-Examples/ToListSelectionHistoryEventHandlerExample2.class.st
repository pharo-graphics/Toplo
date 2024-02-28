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
ToListSelectionHistoryEventHandlerExample2 >> actionCommand: aCommand for: aTarget [

	
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample2 >> addIndexesSelectionCommand: aCommand [ 

	historyList data add:	(currentTarget data at: aCommand indexes last)
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExample2 >> addIntervalSelectionCommand: aCommand [

	| s |
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
	aCommandAppliedEvent command applyOn: self for: self historyList.
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
