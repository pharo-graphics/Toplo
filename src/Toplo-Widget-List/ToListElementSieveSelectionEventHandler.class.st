Class {
	#name : #ToListElementSieveSelectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'sieve',
		'selectionSet',
		'dataPositionIndex'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #'api - accessing' }
ToListElementSieveSelectionEventHandler >> eventsToHandle [

	^ {
		  ToListSelectionChangePreNotificationEvent.
		  ToListSelectionChangedEvent.
		  ToSievedListSelectionChangedEvent.
		  ToListSieveFilterAppliedEvent }
]

{ #category : #'element handlers' }
ToListElementSieveSelectionEventHandler >> listSelectionChangePreNotificationEvent: aPreNotification [

	| sourceEvent newEvent |
	" keep the original "
	sieve pattern ifEmpty: [ ^ self ].
	sourceEvent := aPreNotification selectionChangedEvent.
	newEvent := ToSievedListSelectionChangedEvent new.
	newEvent
		pattern: sieve pattern;
		selectionModel: sourceEvent selectionModel copy.
	aPreNotification currentTarget dispatchEvent: newEvent.
	aPreNotification currentTarget dispatchEvent: ToListSelectionDirtyEvent new.
	aPreNotification selectionChangedEvent: nil
]

{ #category : #'element handlers' }
ToListElementSieveSelectionEventHandler >> listSelectionChangedEvent: anEvent [

	selectionSet removeAll.
	selectionSet addAll: anEvent selectionModel selectedIndexes
]

{ #category : #'element handlers' }
ToListElementSieveSelectionEventHandler >> listSieveFilterAppliedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target dataAccessor itemCount > 0 ifFalse: [ ^ self ].
	anEvent sieve pattern
		ifNotEmpty: [
			| selected |
			selected := OrderedCollection new.
			target dataAccessor withIndexDo: [ :d :localIndex |
				| originalIndex |
				originalIndex := dataPositionIndex at: d.
				(selectionSet includes: originalIndex) ifTrue: [
					selected add: localIndex ] ].
			target selecter selectAllIndexes: selected ]
		ifEmpty: [ target selecter selectOnlyIndexes: selectionSet asArray ]
]

{ #category : #'api - hooks' }
ToListElementSieveSelectionEventHandler >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	selectionSet := IdentitySet new.
	selectionSet addAll: aListElement selectionModel selectedIndexes.
	dataPositionIndex := IdentityDictionary new.
	aListElement dataAccessor withIndexDo: [ :aData :idx |
		dataPositionIndex at: aData put: idx ]
]

{ #category : #accessing }
ToListElementSieveSelectionEventHandler >> sieve: aListElementSieve [

	sieve := aListElementSieve
]

{ #category : #'element handlers' }
ToListElementSieveSelectionEventHandler >> sievedListSelectionChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target dataAccessor withIndexDo: [ :d :localIdx |
		| originalIndex |
		originalIndex := dataPositionIndex at: d.
		(anEvent selectionModel containsIndex: localIdx)
			ifTrue: [ selectionSet add: originalIndex ]
			ifFalse: [ selectionSet remove: originalIndex ifAbsent: []] ]
]
