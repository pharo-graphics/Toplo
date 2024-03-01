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

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> collectionFilteredEvent: anEvent [

	" the list has been filtered - now deal with the selection "

	| target selected |

	target := anEvent currentTarget.
	selected := sieve pattern
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

{ #category : #'api - accessing' }
ToSievedListElementEventHandler >> eventsToHandle [

	^ {
		  BlInfiniteDataSourceEvent.
		  ToListChangePreNotificationEvent.
		  ToCollectionFilteredEvent }
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
	" the list selection change event is about to be dispatched.
	take care of the selectionSet according to the list element selection model"

	| primSelChangedEvent listElement selModel |
	listElement := aPreNotification currentTarget.

	" reset the selection in case of single selection mode "
	aPreNotification currentTarget isMultipleSelection ifFalse: [
		selectionSet removeAll ].

	primSelChangedEvent := aPreNotification sourceEvent.
	selModel := primSelChangedEvent selectionModel.

	" the selection set is updated according to the pattern:
	- if empty, the whole selection set is set from the whole list element selection model 
	- if not empty, the selection set is computed according to the current list node list "
	sieve pattern
		ifEmpty: [
			| prevSet |
			prevSet := selectionSet.
			selectionSet := selModel selectedIndexes asIdentitySet.
			(prevSet notEmpty and: [ prevSet = selectionSet ]) ifTrue: [
				^ self ] ]
		ifNotEmpty: [
			listElement dataAccessor withIndexDo: [ :d :localIdx |
				| originalIndex |
				originalIndex := dataPositionIndex at: d.
				(selModel containsIndex: localIdx)
					ifTrue: [ selectionSet add: originalIndex ]
					ifFalse: [ selectionSet remove: originalIndex ifAbsent: [  ] ] ] ].

	listElement dispatchEvent:
		(ToSieveSelectionChangedEvent new selectionModel:
			 (listElement newSelectionModel
				  selectIndexes: selectionSet;
				  yourself))
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
