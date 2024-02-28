Class {
	#name : #ToSievedListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'sieve',
		'selectionSet',
		'dataPositionIndex'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #'api - hooks' }
ToSievedListElementEventHandler >> buildIndexedDataFrom: aListElement [

	dataPositionIndex := IdentityDictionary new.
	aListElement dataAccessor withIndexDo: [ :aData :idx |
		dataPositionIndex at: aData put: idx ]
]

{ #category : #'api - accessing' }
ToSievedListElementEventHandler >> eventsToHandle [

	^ {
		  BlInfiniteDataSourceEvent.
		  ToListChangePreNotificationEvent.
		  ToListPrimarySelectionChangedEvent.
		  ToSievedListSelectionChangedEvent.
		  ToSieveAppliedEvent }
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> listClickOnNodePreNotificationEvent: anEvent [

]

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> listDataSourceItemsChangePreNotificationEvent: aPreNotification [
	" don't send the data source add/remove change event if the sieve is filtering"

	sieve pattern ifEmpty: [
		^ self ].
	" the data source event should not be sent. this is why the source event is changed with nil "
	aPreNotification sourceEvent: nil
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> listPrimarySelectionChangePreNotificationEvent: aPreNotification [

	| sourceEvent newEvent |
	sieve pattern ifEmpty: [ ^ self ].
	
	" reset the selection in case off single selection mode "
	aPreNotification currentTarget isMultipleSelection ifFalse: [
		selectionSet removeAll ].
	sourceEvent := aPreNotification sourceEvent.
	newEvent := ToSievedListSelectionChangedEvent new.
	newEvent
		pattern: sieve pattern;
		selectionModel: sourceEvent selectionModel copy.
	aPreNotification currentTarget dispatchEvent: newEvent.
	" in case the sieve is mute, don't let listSelectionChangedEvent be sent "
	sieve isMute ifTrue: [ aPreNotification sourceEvent: nil ]

]

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [
	" the selection is fully updated with an empty pattern "

	| prevSet |
	sieve pattern ifNotEmpty: [ ^ self ].
	prevSet := selectionSet.
	selectionSet := IdentitySet new.
	selectionSet addAll: anEvent selectionModel selectedIndexes.
	(prevSet notEmpty and: [ prevSet = selectionSet]) ifTrue: [ ^ self ].
	anEvent currentTarget dispatchEvent:
		(ToSieveSelectionChangedEvent new
			 selectionModel: anEvent selectionModel copy;
			 yourself)
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> onChanged: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: anEvent currentTarget
]

{ #category : #'api - hooks' }
ToSievedListElementEventHandler >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	selectionSet := IdentitySet new.
	selectionSet addAll: aListElement selectionModel selectedIndexes.
	self buildIndexedDataFrom: aListElement
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> onItemsChanged: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: anEvent currentTarget
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> onItemsEvent: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: anEvent currentTarget
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> onItemsInserted: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: anEvent currentTarget
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> onItemsRemoved: anEvent [

	" no need to update dataPositionIndex here "
]

{ #category : #accessing }
ToSievedListElementEventHandler >> sieve: aListElementSieve [

	sieve := aListElementSieve
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> sieveAppliedEvent: anEvent [

	| target selected |

	target := anEvent currentTarget.
	selected := anEvent sieve pattern
		            ifNotEmpty: [
			            Array streamContents: [ :stream |
				            target dataAccessor withIndexDo: [ :d :localIndex |
					            | originalIndex |
					            originalIndex := dataPositionIndex at: d.
					            (selectionSet includes: originalIndex) ifTrue: [
						            stream nextPut: localIndex ] ] ] ]
		            ifEmpty: [ selectionSet asArray ].
	target selecter selectOnlyIndexes: selected
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> sievedListSelectionChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target dataAccessor withIndexDo: [ :d :localIdx |
		| originalIndex |
		originalIndex := dataPositionIndex at: d.
		(anEvent selectionModel containsIndex: localIdx)
			ifTrue: [ selectionSet add: originalIndex ]
			ifFalse: [ selectionSet remove: originalIndex ifAbsent: [  ] ] ].
	anEvent currentTarget dispatchEvent:
		(ToSieveSelectionChangedEvent new selectionModel:
			 (anEvent currentTarget newSelectionModel
				  selectIndexes: selectionSet;
				  yourself))
]
