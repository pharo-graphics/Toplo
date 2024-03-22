Class {
	#name : #ToSievedListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'sieve',
		'dataPositionIndex',
		'sieveSelectionModel',
		'queryApplicationTask'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> applyQueryAppliedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	" a query has occured (because the query pattern has changed), update the list element accordingly "
	sieve updateCurrentData.
	" update the list element but not the selection "
	" *** note that it is required to deselect all here - 
		the selection is managed after (see #collectionFilteredEvent: ) *** "
	listElement selectionModel deselectAll.
	listElement dataAccessor filterResult: sieve currentData
]

{ #category : #'api - hooks' }
ToSievedListElementEventHandler >> buildIndexedDataFrom: aListElement [


	dataPositionIndex removeAll.
	aListElement dataAccessor withIndexDo: [ :aData :idx |
		dataPositionIndex at: aData put: idx ]
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> collectionFilteredEvent: anEvent [
	" the list has been filtered - now deal with the selection "

	| target |
	target := anEvent currentTarget.

	sieve pattern
		ifNotEmpty: [
			target dataAccessor withIndexDo: [ :d :localIndex |
				| originalIndex |
				originalIndex := dataPositionIndex at: d.
				target selectionModel
					transferIndex: originalIndex
					from: sieveSelectionModel
					as: localIndex ] ]
		ifEmpty: [
		self flag: 'Should use copySelectionFrom: with a command '.
		target selecter selectOnlyIndexes: sieveSelectionModel selectedIndexes ]
]

{ #category : #accessing }
ToSievedListElementEventHandler >> dataPositionIndex [

	^ dataPositionIndex 
]

{ #category : #accessing }
ToSievedListElementEventHandler >> dataPositionIndex: aDictionary [

	dataPositionIndex := aDictionary
]

{ #category : #'api - accessing' }
ToSievedListElementEventHandler >> eventsToHandle [

	^ {
		  ToObservableCollectionFilterResultEvent.
		  BlInfiniteDataSourceEvent.
		  ToListChangePreNotificationEvent.
		  ToCollectionFilteredEvent }
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> infiniteDataSourceChanged: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: anEvent currentTarget
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> infiniteDataSourceItemRangeChanged: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: anEvent currentTarget
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> infiniteDataSourceItemRangeEvent: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: anEvent currentTarget
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> infiniteDataSourceItemRangeInserted: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexedDataFrom: anEvent currentTarget
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> infiniteDataSourceItemRangeRemoved: anEvent [

	" no need to update dataPositionIndex here "
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
	I take care of the sieve internal selectionSet according to the list element selection model"

	| primSelChangedEvent listElement listSelModel |
	listElement := aPreNotification currentTarget.

	" reset the selection in case of single selection mode "
	aPreNotification currentTarget isMultipleSelection ifFalse: [
		sieveSelectionModel deselectAll ].

	primSelChangedEvent := aPreNotification sourceEvent.
	listSelModel := primSelChangedEvent selectionModel.

	" the selection set is updated according to the pattern:
	- if empty, the whole selection set is set from the whole list element selection model 
	- if not empty, the selection set is computed according to the current list node list "
	sieve pattern
		ifEmpty: [
		sieveSelectionModel copySelectionFrom: listElement selectionModel ]
		ifNotEmpty: [
			listElement dataAccessor withIndexDo: [ :d :localIndex |
				| originalIndex |
				originalIndex := dataPositionIndex at: d.
				sieveSelectionModel
					transferIndex: localIndex
					from: listSelModel
					as: originalIndex ] ].

	" dispatch a specific, different from the primary selection change event that will be sent after.
	It is useful for sieve list user that relies on the sieve internal selection to adapt themeself according 
	to the sieve selection"
	listElement dispatchEvent: (ToSieveSelectionChangedEvent new
			 selectionModel: sieveSelectionModel copy;
			 yourself)
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> observableCollectionFilterResultEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.

	" a query has occured (becuse the query pattern has changed), 
	update the list element accordingly "

	" if the update task is already present, do nothing "
	queryApplicationTask ifNotNil: [ ^ self ].

	" can apply immediately if not attached "
	listElement isAttachedToSceneGraph ifFalse: [
		self applyQueryAppliedEvent: anEvent.
		^ self ].

	" enqueue a task for updating "
	queryApplicationTask := BlTaskAction new.
	queryApplicationTask action: [
		self applyQueryAppliedEvent: anEvent.
		queryApplicationTask := nil ].
	listElement enqueueTask: queryApplicationTask
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> onChanged: anEvent [

	self infiniteDataSourceChanged: anEvent
]

{ #category : #'api - hooks' }
ToSievedListElementEventHandler >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	sieveSelectionModel := aListElement selectionModel copy.
	self dataPositionIndex: sieve dataPositionIndex.
	self buildIndexedDataFrom: aListElement
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> onItemsChanged: anEvent [

	self infiniteDataSourceItemRangeChanged: anEvent
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> onItemsEvent: anEvent [

	self infiniteDataSourceItemRangeEvent: anEvent
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> onItemsInserted: anEvent [

	self infiniteDataSourceItemRangeInserted: anEvent
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler >> onItemsRemoved: anEvent [

	self infiniteDataSourceItemRangeRemoved: anEvent
]

{ #category : #accessing }
ToSievedListElementEventHandler >> sieve: aListElementSieve [

	sieve := aListElementSieve
]
