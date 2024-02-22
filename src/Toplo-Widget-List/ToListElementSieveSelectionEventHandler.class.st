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

{ #category : #'api - hooks' }
ToListElementSieveSelectionEventHandler >> buildIndexedDataFrom: aListElement [

	dataPositionIndex := IdentityDictionary new.
	aListElement dataAccessor withIndexDo: [ :aData :idx |
		dataPositionIndex at: aData put: idx ]
]

{ #category : #'api - accessing' }
ToListElementSieveSelectionEventHandler >> eventsToHandle [

	^ {
		  BlInfiniteDataSourceEvent.
		  ToListChangePreNotificationEvent.
		  ToListSelectionChangedEvent.
		  ToSievedListSelectionChangedEvent.
		  ToListSieveFilterAppliedEvent }
]

{ #category : #'element handlers' }
ToListElementSieveSelectionEventHandler >> listDataSourceItemsChangePreNotificationEvent: aPreNotification [
	" don't send the data source add/remove change event if the sieve is filtering"

	sieve pattern ifEmpty: [
		^ self ].
	" the data source event should not be sent. this is why the source event is changed with nil "
	aPreNotification sourceEvent: nil
]

{ #category : #'element handlers' }
ToListElementSieveSelectionEventHandler >> listSelectionChangePreNotificationEvent: aPreNotification [

	| sourceEvent newEvent |
	sieve pattern ifEmpty: [ ^ self ].
	sourceEvent := aPreNotification sourceEvent.
	newEvent := ToSievedListSelectionChangedEvent new.
	newEvent
		pattern: sieve pattern;
		selectionModel: sourceEvent selectionModel copy.
	aPreNotification currentTarget dispatchEvent: newEvent.
	" let listSelectionChangedEvent be sent to update the selection properly "
]

{ #category : #'element handlers' }
ToListElementSieveSelectionEventHandler >> listSelectionChangedEvent: anEvent [

	" the selection is fully updated with an empty pattern "
	sieve pattern ifNotEmpty: [ ^ self ].
	selectionSet removeAll.
	selectionSet addAll: anEvent selectionModel selectedIndexes
]

{ #category : #'element handlers' }
ToListElementSieveSelectionEventHandler >> listSieveFilterAppliedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	anEvent sieve pattern
		ifNotEmpty: [
			| selected |
			selected := Array streamContents: [ :stream |
				            target dataAccessor withIndexDo: [ :d :localIndex |
					            | originalIndex |
					            originalIndex := dataPositionIndex at: d.
					            (selectionSet includes: originalIndex) ifTrue: [
						            stream nextPut: localIndex ] ] ].
			target selecter selectOnlyIndexes: selected ]
		ifEmpty: [ target selecter selectOnlyIndexes: selectionSet asArray ]
]

{ #category : #'data events handling' }
ToListElementSieveSelectionEventHandler >> onChanged: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: anEvent currentTarget
]

{ #category : #'api - hooks' }
ToListElementSieveSelectionEventHandler >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	selectionSet := IdentitySet new.
	selectionSet addAll: aListElement selectionModel selectedIndexes.
	self buildIndexedDataFrom: aListElement
]

{ #category : #'data events handling' }
ToListElementSieveSelectionEventHandler >> onItemsChanged: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: anEvent currentTarget
]

{ #category : #'data events handling' }
ToListElementSieveSelectionEventHandler >> onItemsEvent: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: anEvent currentTarget
]

{ #category : #'data events handling' }
ToListElementSieveSelectionEventHandler >> onItemsInserted: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: anEvent currentTarget
]

{ #category : #'data events handling' }
ToListElementSieveSelectionEventHandler >> onItemsRemoved: anEvent [

	" no need to update dataPositionIndex here "
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
