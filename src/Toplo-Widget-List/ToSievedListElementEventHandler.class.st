Class {
	#name : #ToSievedListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'sieve',
		'dataPositionIndex',
		'sieveSelectionModel'
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
		 " ToObservableCollectionFilterResultEvent."
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

	| listElement listSelModel |
	listElement := aPreNotification currentTarget.
	listSelModel := listElement selectionModel.
	" first check if the request is for the primary selection model "
	listSelModel == aPreNotification selectionModel ifFalse: [ ^ self ].

	" have to do nothing if the list is empty. Else, the selection can be lost in case of single select"
	listElement dataAccessor ifEmpty: [ ^ self ].
	" reset the selection in case of single selection mode "
	aPreNotification currentTarget isMultipleSelection ifFalse: [
		sieveSelectionModel deselectAll ].

	" the selection set is updated according to the pattern:
	- if empty, the whole selection set is set from the whole list element selection model 
	- if not empty, the selection set is computed according to the current list node list "
	sieve pattern
		ifEmpty: [
			sieveSelectionModel copySelectionFrom: listSelModel ]
		ifNotEmpty: [ 
			listElement dataAccessor withIndexDo: [ :d :localIndex |
				| originalIndex |
				originalIndex := dataPositionIndex at: d.
				listSelModel
					transferSelectionFromIndex: localIndex
					toIndex: originalIndex
					in: sieveSelectionModel ] ].

	" dispatch a specific, different from the primary selection change event that will be sent after.
	It is useful for sieve list user that relies on the sieve internal selection to adapt themeself 
	according to the sieve selection"
	listElement dispatchEvent: (ToSieveSelectionChangedEvent new
			 sieve: sieve;
			 selectionModel: sieveSelectionModel;
			 yourself)
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
