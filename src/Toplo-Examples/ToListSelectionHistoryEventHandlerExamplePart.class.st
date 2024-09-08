"
I'm part of a larger example. I'm not expected to be used as a standalone.
"
Class {
	#name : #ToListSelectionHistoryEventHandlerExamplePart,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'historyList',
		'currentTarget'
	],
	#category : #'Toplo-Examples-Parts'
}

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExamplePart >> addIndexesSelectionCommand: aCommand [

	aCommand operation deselectAllBefore ifTrue: [
		historyList data removeAll ].
	historyList data add: (currentTarget data at: aCommand indexes last)
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExamplePart >> addIntervalSelectionCommand: aCommand [

	| s |
	aCommand operation deselectAllBefore ifTrue: [
		historyList dataAccessor removeAll ].
	s := currentTarget dataAccessor at: aCommand to.
	(historyList dataAccessor includes: s) ifTrue: [
		historyList dataAccessor remove: s ].
	historyList dataAccessor add: s
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExamplePart >> addWholeSelectionCommand: aCommand [

	(historyList dataAccessor includes: currentTarget dataAccessor last)
		ifTrue: [ ^ self ].
	historyList dataAccessor add: currentTarget dataAccessor last
]

{ #category : #'api - accessing' }
ToListSelectionHistoryEventHandlerExamplePart >> eventsToHandle [

	^ { ToListSelectionCommandAppliedEvent }
]

{ #category : #accessing }
ToListSelectionHistoryEventHandlerExamplePart >> historyList [

	^ historyList
]

{ #category : #accessing }
ToListSelectionHistoryEventHandlerExamplePart >> historyList: aList [

	historyList := aList
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExamplePart >> listSelectionCommandAppliedEvent: aCommandAppliedEvent [

	currentTarget := aCommandAppliedEvent currentTarget.
	" check that the command is applied on the primary selection model "
	aCommandAppliedEvent selectionModel = currentTarget selectionModel
		ifFalse: [ ^ self ].
	aCommandAppliedEvent command applyWithOperator: self.
	currentTarget := nil
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExamplePart >> removeIndexesSelectionCommand: aCommand [


]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExamplePart >> removeIntervalSelectionCommand: aCommand [

	(historyList dataAccessor includes:
		 (currentTarget dataAccessor at: aCommand to)) ifFalse: [ ^ self ].
	historyList dataAccessor remove:
		(currentTarget dataAccessor at: aCommand to)
]

{ #category : #'event handling' }
ToListSelectionHistoryEventHandlerExamplePart >> removeWholeSelectionCommand: aCommand [

	historyList dataAccessor removeAll
]
