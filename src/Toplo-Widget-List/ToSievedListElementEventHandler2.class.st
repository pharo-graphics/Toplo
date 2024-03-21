Class {
	#name : #ToSievedListElementEventHandler2,
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
ToSievedListElementEventHandler2 >> applyQueryAppliedEvent: anEvent [

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
ToSievedListElementEventHandler2 >> buildIndexesFrom: aListElement [


	dataPositionIndex removeAll.
	aListElement dataAccessor withIndexDo: [ :aData :idx |
		dataPositionIndex at: aData put: idx ]
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler2 >> collectionFilteredEvent: anEvent [
	" the list has been filtered - now deal with the selection "

	| target selected |
	target := anEvent currentTarget.

	selected := sieve pattern
		            ifNotEmpty: [
			            Array streamContents: [ :stream |
				            target dataAccessor withIndexDo: [ :d :localIndex |
					            | originalIndex |
					            originalIndex := dataPositionIndex at: d.
					            (sieveSelectionModel containsIndex: originalIndex)
						            ifTrue: [ stream nextPut: localIndex ] ] ] ]
		            ifEmpty: [ sieveSelectionModel selectedIndexes ].
	target selecter selectOnlyIndexes: selected
]

{ #category : #accessing }
ToSievedListElementEventHandler2 >> dataPositionIndex [

	^ dataPositionIndex 
]

{ #category : #accessing }
ToSievedListElementEventHandler2 >> dataPositionIndex: aDictionary [

	dataPositionIndex := aDictionary
]

{ #category : #'api - accessing' }
ToSievedListElementEventHandler2 >> eventsToHandle [

	^ {
		  ToObservableCollectionFilterResultEvent.
		  BlInfiniteDataSourceEvent.
		  ToListChangePreNotificationEvent.
		  ToCollectionFilteredEvent }
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler2 >> infiniteDataSourceChanged: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexesFrom: anEvent currentTarget
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler2 >> infiniteDataSourceItemRangeChanged: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexesFrom: anEvent currentTarget
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler2 >> infiniteDataSourceItemRangeEvent: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexesFrom: anEvent currentTarget
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler2 >> infiniteDataSourceItemRangeInserted: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildIndexesFrom: anEvent currentTarget
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler2 >> infiniteDataSourceItemRangeRemoved: anEvent [

	" no need to update dataPositionIndex here "
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler2 >> listClickOnNodePreNotificationEvent: anEvent [

]

{ #category : #'element handlers' }
ToSievedListElementEventHandler2 >> listDataSourceItemsChangePreNotificationEvent: aPreNotification [
	" don't send the data source add/remove change event if the sieve is filtering"

	sieve pattern ifEmpty: [
		^ self ].
	" the data source event should not be sent. this is why the source event is changed with nil "
	aPreNotification sourceEvent: nil
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler2 >> listPrimarySelectionChangePreNotificationEvent: aPreNotification [
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
			listElement dataAccessor withIndexDo: [ :d :localIdx |
				| originalIndex |
				originalIndex := dataPositionIndex at: d.
				(listSelModel containsIndex: localIdx)
					ifTrue: [ sieveSelectionModel selectIndex: originalIndex ]
					ifFalse: [ sieveSelectionModel deselectIndex: originalIndex ] ] ].

	" dispatch a specific, different from the primary selection change event that will be sent after.
	It is useful for sieve list user that relies on the sieve internal selection to adapt themeself according 
	to the sieve selection"
	listElement dispatchEvent: (ToSieveSelectionChangedEvent new
			 selectionModel: sieveSelectionModel copy;
			 yourself)
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler2 >> listSecondarySelectionChangePreNotificationEvent: aPreNotification [
	" nothing to do "
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler2 >> observableCollectionFilterResultEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.

	" a query has occured (becuse the query pattern has changed), 
	update the list element accordingly "
	
	queryApplicationTask ifNotNil: [
		listElement dequeueTask: queryApplicationTask.
		queryApplicationTask := nil ].
	listElement isAttachedToSceneGraph ifFalse: [
		self applyQueryAppliedEvent: anEvent.
		^ self ].
	queryApplicationTask := BlTaskAction new.
	queryApplicationTask action: [
		queryApplicationTask := nil.
		self applyQueryAppliedEvent: anEvent ].
	listElement enqueueTask: queryApplicationTask
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler2 >> onChanged: anEvent [

	self infiniteDataSourceChanged: anEvent
]

{ #category : #'api - hooks' }
ToSievedListElementEventHandler2 >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	sieveSelectionModel := aListElement selectionModel copy.
	self dataPositionIndex: sieve dataPositionIndex.
	self buildIndexesFrom: aListElement
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler2 >> onItemsChanged: anEvent [

	self infiniteDataSourceItemRangeChanged: anEvent
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler2 >> onItemsEvent: anEvent [

	self infiniteDataSourceItemRangeEvent: anEvent
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler2 >> onItemsInserted: anEvent [

	self infiniteDataSourceItemRangeInserted: anEvent
]

{ #category : #'data events handling' }
ToSievedListElementEventHandler2 >> onItemsRemoved: anEvent [

	self infiniteDataSourceItemRangeRemoved: anEvent
]

{ #category : #accessing }
ToSievedListElementEventHandler2 >> sieve: aListElementSieve [

	sieve := aListElementSieve
]
