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

{ #category : #'api - hooks' }
ToSievedListElementEventHandler >> buildOriginalIndexMapFrom: aListElement [


	dataPositionIndex removeAll.
	aListElement dataAccessor withIndexDo: [ :aData :idx |
		dataPositionIndex at: aData put: idx ]
]

{ #category : #'api - accessing' }
ToSievedListElementEventHandler >> eventsToHandle [

	^ {
		  ToObservableCollectionFilterResultEvent.
		  BlInfiniteDataSourceChanged.
		  BlInfiniteDataSourceItemRangeChanged.
		  BlInfiniteDataSourceItemRangeInserted.
		  BlInfiniteDataSourceItemRangeRemoved.
		  ToListSelectionCommandAppliedEvent }
]

{ #category : #'data source events handling' }
ToSievedListElementEventHandler >> infiniteDataSourceChanged: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildOriginalIndexMapFrom: anEvent currentTarget
]

{ #category : #'data source events handling' }
ToSievedListElementEventHandler >> infiniteDataSourceItemRangeChanged: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildOriginalIndexMapFrom: anEvent currentTarget
]

{ #category : #'data source events handling' }
ToSievedListElementEventHandler >> infiniteDataSourceItemRangeInserted: anEvent [

	sieve pattern ifNotEmpty: [ ^ self ].
	self buildOriginalIndexMapFrom: anEvent currentTarget
]

{ #category : #'data source events handling' }
ToSievedListElementEventHandler >> infiniteDataSourceItemRangeRemoved: anEvent [

	" no need to update dataPositionIndex here "
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> listSelectionCommandAppliedEvent: aPreNotification [
	" the list selection change event is about to be dispatched.
	I take care of the sieve internal selectionSet according to the list element selection model"

	| listElement listSelModel touchedIndexes |
	listElement := aPreNotification currentTarget.
	listSelModel := listElement selectionModel.
	" first check if the request is for the primary selection model "
	listSelModel = aPreNotification selectionModel ifFalse: [ ^ self ].

	" reset the selection in case of single selection mode "
	aPreNotification currentTarget isMultipleSelection ifFalse: [
		sieveSelectionModel deselectAll ].

	" the selection set is updated according to the pattern:
	- if empty, the whole selection set is set from the whole list element selection model 
	- if not empty, the selection set is computed according to the current list node list "
	sieve pattern
		ifEmpty: [
			touchedIndexes := aPreNotification command indexes.
			sieveSelectionModel copySelectionFrom: listSelModel ]
		ifNotEmpty: [
			touchedIndexes := OrderedCollection new.
			aPreNotification command indexes do: [ :localIndex |
				| originalIndex dataItem |
				dataItem := listElement dataAccessor at: localIndex.
				originalIndex := dataPositionIndex at: dataItem.
				touchedIndexes add: originalIndex.
				listSelModel
					transferSelectionFromIndex: localIndex
					toIndex: originalIndex
					in: sieveSelectionModel ] ].

	" dispatch a specific, different from the primary selection change event that will be sent after.
	It is useful for sieve list user that relies on the sieve internal selection to adapt themeself 
	according to the sieve selection"
	listElement dispatchEvent: (ToSieveSelectionChangedEvent new
			 sieve: sieve;
			 touchedIndexes: touchedIndexes asArray;
			 selectionModel: sieveSelectionModel;
			 yourself)
]

{ #category : #'element handlers' }
ToSievedListElementEventHandler >> observableCollectionFilterResultEvent: anEvent [


	| listElement |
	listElement := anEvent currentTarget.

	" a query has occured (because the query pattern has changed), update the list element accordingly "
	sieve updateCurrentData.

	" ask the list to process the appropiate data source command and to update the selection model"
	listElement sieveResultWith: sieve
]

{ #category : #'api - hooks' }
ToSievedListElementEventHandler >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	sieveSelectionModel := sieve selectionModel.
	self originalIndexMap: sieve originalIndexMap.
	self buildOriginalIndexMapFrom: aListElement
]

{ #category : #accessing }
ToSievedListElementEventHandler >> originalIndexMap: aDictionary [

	dataPositionIndex := aDictionary
]

{ #category : #accessing }
ToSievedListElementEventHandler >> sieve: aListElementSieve [

	sieve := aListElementSieve
]
