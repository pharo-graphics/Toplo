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

	sieve pattern ifEmpty: [ ^ self ].
	" don't send the data source add/remove change event if the sieve is filtering"
	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: aPreNotification currentTarget.
	aPreNotification sourceEvent: nil
]

{ #category : #'element handlers' }
ToListElementSieveSelectionEventHandler >> listSelectionChangePreNotificationEvent: aPreNotification [

	| sourceEvent newEvent |
	" keep the original "
	sieve pattern ifEmpty: [ ^ self ].
	sourceEvent := aPreNotification sourceEvent.
	newEvent := ToSievedListSelectionChangedEvent new.
	newEvent
		pattern: sieve pattern;
		selectionModel: sourceEvent selectionModel copy.
	aPreNotification currentTarget dispatchEvent: newEvent
]

{ #category : #'element handlers' }
ToListElementSieveSelectionEventHandler >> listSelectionChangedEvent: anEvent [

	" the selection is fully updated only without filter "
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
			selected := OrderedCollection new.
			target dataAccessor withIndexDo: [ :d :localIndex |
				| originalIndex |
				originalIndex := dataPositionIndex at: d.
				(selectionSet includes: originalIndex) ifTrue: [
					selected add: localIndex ] ].
			target selecter selectAllIndexes: selected ]
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

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: anEvent currentTarget
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
