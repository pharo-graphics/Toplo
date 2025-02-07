"
I'm part of a larger example. I'm not expected to be used as a standalone.
"
Class {
	#name : #ToListSelectionHistoryExampleEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'historyList',
		'currentTarget'
	],
	#category : #'Toplo-Examples-Parts'
}

{ #category : #'command handling' }
ToListSelectionHistoryExampleEventHandler >> addIndexesSelectionCommand: aCommand [

	aCommand operation deselectAllBefore ifTrue: [
		historyList data removeAll ].
	historyList data add: (currentTarget data at: aCommand indexes last)
]

{ #category : #'command handling' }
ToListSelectionHistoryExampleEventHandler >> addIntervalSelectionCommand: aCommand [

	| s |
	aCommand operation deselectAllBefore ifTrue: [
		historyList dataAccessor removeAll ].
	s := currentTarget dataAccessor at: aCommand to.
	(historyList dataAccessor includes: s) ifTrue: [
		historyList dataAccessor remove: s ].
	historyList dataAccessor add: s
]

{ #category : #'command handling' }
ToListSelectionHistoryExampleEventHandler >> addWholeSelectionCommand: aCommand [

	(historyList dataAccessor includes: currentTarget dataAccessor last)
		ifTrue: [ ^ self ].
	historyList dataAccessor add: currentTarget dataAccessor last
]

{ #category : #'api - accessing' }
ToListSelectionHistoryExampleEventHandler >> eventsToHandle [

	^ { ToListSelectionCommandAppliedEvent }
]

{ #category : #accessing }
ToListSelectionHistoryExampleEventHandler >> historyList [

	^ historyList
]

{ #category : #accessing }
ToListSelectionHistoryExampleEventHandler >> historyList: aList [

	historyList := aList
]

{ #category : #'event handling' }
ToListSelectionHistoryExampleEventHandler >> listSelectionCommandAppliedEvent: aCommandAppliedEvent [

	currentTarget := aCommandAppliedEvent currentTarget.
	" check that the command is applied on the primary selection model "
	aCommandAppliedEvent selectionModel == currentTarget selectionModel
		ifFalse: [ ^ self ].
	aCommandAppliedEvent command applyWithOperator: self.
	currentTarget := nil
]

{ #category : #'command handling' }
ToListSelectionHistoryExampleEventHandler >> removeIndexesSelectionCommand: aCommand [


]

{ #category : #'command handling' }
ToListSelectionHistoryExampleEventHandler >> removeIntervalSelectionCommand: aCommand [

	(historyList dataAccessor includes:
		 (currentTarget dataAccessor at: aCommand to)) ifFalse: [ ^ self ].
	historyList dataAccessor remove:
		(currentTarget dataAccessor at: aCommand to)
]

{ #category : #'command handling' }
ToListSelectionHistoryExampleEventHandler >> removeWholeSelectionCommand: aCommand [

	historyList dataAccessor removeAll
]
