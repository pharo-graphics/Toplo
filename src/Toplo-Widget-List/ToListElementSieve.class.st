Class {
	#name : #ToListElementSieve,
	#superclass : #Object,
	#instVars : [
		'queryRunner',
		'originalData',
		'listElement',
		'originalDataUpdater',
		'originalIndexedData',
		'originalIndexedDataArray',
		'selectionChangedHandler',
		'queryResultHandler',
		'currentResultsArray',
		'currentSelection',
		'originalIndexedDataIndex',
		'queryApplicationTask'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #'selection command' }
ToListElementSieve >> addIndexesSelectionCommand: aCommand [


]

{ #category : #'selection command' }
ToListElementSieve >> addIntervalSelectionCommand: aCommand [


]

{ #category : #'selection command' }
ToListElementSieve >> addWholeSelectionCommand: aCommand [
]

{ #category : #'event handling' }
ToListElementSieve >> applyObservableCollectionQueryResultEvent [
	" a query has occured (becuse the query pattern has changed), update the list element accordingly "

	| selectedIndexes |
	" get the filtered data "
	self buildCurrentQueryResults.
	" now the selected indexes "
	selectedIndexes := queryRunner pattern
		                   ifEmpty: [ currentSelection asArray ]
		                   ifNotEmpty: [
			                   Array streamContents: [ :stream |
				                   currentResultsArray withIndexDo: [ :assoc :idx |
					                   (currentSelection includes: assoc value)
						                   ifTrue: [ stream nextPut: idx ] ] ] ].
	"Update litElement data together with the selection "

	" beSilentWhile: to avoid #ToListSelectionChangedEvent dispatches from the selecter.
	It is necessary because the result would not be correct (because of the event selected indexes)"
	listElement selecter beSilentWhile: [
	listElement dataAccessor filterResult:
		(currentResultsArray collect: [ :assoc | assoc key ]).
		listElement selecter selectOnlyIndexes: selectedIndexes.
		listElement dispatchEvent: (ToListSelectionChangedEvent new
				 selectionModel: (listElement newSelectionModel
						  selectAllIndexes: selectedIndexes;
						  yourself);
				 yourself).
		listElement dispatchEvent: (ToListSieveFilterAppliedEvent new
				 sieve: self;
				 yourself) ]
]

{ #category : #accessing }
ToListElementSieve >> buildCurrentQueryResults [

	currentResultsArray := queryRunner pattern
		                       ifEmpty: [  originalIndexedDataArray ]
		                       ifNotEmpty: [
			                       queryRunner selectedIndexes collect: [ :idx |
				                       originalIndexedDataArray at: idx ] ]
]

{ #category : #private }
ToListElementSieve >> buildOriginalIndexedData [

	| assocs |
	assocs := Array streamContents: [ :str |
		          originalData withIndexDo: [ :d :i | str nextPut: d -> i ] ].
	originalIndexedData updateAllWith: assocs.
	originalIndexedDataArray := originalIndexedData asArray.
	originalIndexedDataIndex := IdentityDictionary new.
	assocs do: [:a | originalIndexedDataIndex at: a key put: a value ]
]

{ #category : #accessing }
ToListElementSieve >> currentSelection [

	^ currentSelection 
]

{ #category : #accessing }
ToListElementSieve >> dataFilter: aValuable [
	" filter takes a data and a pattern as argument "

	queryRunner dataFilter: [ :assoc : pattern | aValuable value: assoc key value: pattern ]
]

{ #category : #'event handling' }
ToListElementSieve >> onCollectionAfterChangeEvent: anEvent [

	listElement selecter deselectAll.
	self buildOriginalIndexedData.
	self pattern
		ifNotEmpty: [ self pattern: '' ]
		ifEmpty: [ self buildCurrentQueryResults ]
]

{ #category : #'event handling' }
ToListElementSieve >> onCommandAppliedEvent: aCommandAppliedEvent [

	aCommandAppliedEvent command traceCr.
	aCommandAppliedEvent command applyOn: self for: listElement
]

{ #category : #'api - hooks' }
ToListElementSieve >> onInstalledIn: aListElement [
	" install the sieve on the listElement "

	| commandHandler |
	listElement := aListElement.

	originalData ifNotNil: [
		^ (BlImmutableObjectChangeError object: self) signal ].
	originalData := aListElement dataAccessor newMirror.
	originalIndexedData := ToObservableCollection new.

	" handler to update the original indexed data if the list element data contents change 
	** after ** the sieve installation"
	originalDataUpdater := BlEventHandler
		                       on: ToCollectionAfterChangeEvent
		                       do: [ :event |
		                       self onCollectionAfterChangeEvent: event ].
	originalData addEventHandler: originalDataUpdater.
	self buildOriginalIndexedData.

	" currentSelection contains the original data selection. It is maintained up-to-date even with a filtered contents "
	currentSelection := aListElement selectionModel selectedIndexes
		                    asIdentitySet.

	" the query runner will run the query in background on the originalIndexedData collection "
	queryRunner := ToObservableCollectionQueryRunner new.
	queryRunner onInstalledIn: originalIndexedData.
	self dataFilter: queryRunner defaultFilter.

	" initialization of the current result with an empty pattern "
	self buildCurrentQueryResults.

	" a filtering occured : put the new data in the list element and 
	update the selection according to the current filtering result "
	queryResultHandler := BlEventHandler
		                      on: ToObservableCollectionQueryResultEvent
		                      do: [ :event |
		                      self onObservableCollectionQueryResultEvent:
			                      event ].
	originalIndexedData addEventHandler: queryResultHandler.

	" a selection occurs in the list element. Have to report it in the originalSelection "
	selectionChangedHandler := BlEventHandler
		                           on: ToListSelectionChangedEvent
		                           do: [ :event |
		                           self onListSelectionChangedEvent: event ].
	aListElement addEventHandler: selectionChangedHandler.

	"commandHandler := BlEventHandler
		                  on: ToSelectionCommandAppliedEvent
		                  do: [ :event | self onCommandAppliedEvent: event ].
	aListElement addEventHandler: commandHandler"
]

{ #category : #'event handling' }
ToListElementSieve >> onListSelectionChangedEvent: anEvent [

	| currentIndexes selectedStream deselectedStream |
	"'onListSelectionChangedEvent:' traceCr."
	currentIndexes := anEvent selectedIndexes asIdentitySet.
	selectedStream := WriteStream on: (Array new: 10).
	deselectedStream := WriteStream on: (Array new: 10).

	currentResultsArray withIndexDo: [ :assoc :idx |
		(currentIndexes includes: idx)
			ifTrue: [ selectedStream nextPut: assoc value ]
			ifFalse: [ deselectedStream nextPut: assoc value ] ].

	currentSelection removeAllFoundIn: deselectedStream contents.
	currentSelection addAll: selectedStream contents.

	listElement selecter beSilentWhile: [
		listElement dispatchEvent: (ToListSieveSelectionChangedEvent new
				 originalData: self originalData;
				 selection: (BlCompositeSelection new
						  selectAllIndexes: currentSelection asArray;
						  yourself);
				 sieve: self;
				 yourself) ]
]

{ #category : #'event handling' }
ToListElementSieve >> onObservableCollectionQueryResultEvent: anEvent [
	" a query has occured (becuse the query pattern has changed), 
	update the list element accordingly "

	queryApplicationTask ifNotNil: [
		listElement dequeueTask: queryApplicationTask.
		queryApplicationTask := nil ].
	listElement isAttachedToSceneGraph ifFalse: [
		self applyObservableCollectionQueryResultEvent.
		^ self ].
	queryApplicationTask := BlTaskAction new.
	queryApplicationTask action: [
		queryApplicationTask := nil.
		self applyObservableCollectionQueryResultEvent ].
	listElement enqueueTask: queryApplicationTask
]

{ #category : #'api - hooks' }
ToListElementSieve >> onUninstalledIn: aListElement [
	" uninstall list element handlers and the queyrunner properly "

	queryRunner onUninstalledIn: originalIndexedData.
	originalData removeEventHandler: originalDataUpdater.
	originalIndexedData removeEventHandler: queryResultHandler.
	aListElement removeEventHandler: selectionChangedHandler.
	queryResultHandler := nil.
	selectionChangedHandler := nil.
	originalIndexedData := nil.
	originalIndexedDataArray := nil.
	originalIndexedDataIndex := nil.
	listElement := nil.
	originalData := nil.
	currentResultsArray := nil.
	queryRunner := nil.
	originalDataUpdater := nil.
	originalIndexedData := nil
]

{ #category : #accessing }
ToListElementSieve >> originalData [ 

	^ originalData 
]

{ #category : #accessing }
ToListElementSieve >> originalIndexOfData: aData [

	^ originalIndexedDataIndex at: aData ifAbsent: [  ]
]

{ #category : #accessing }
ToListElementSieve >> pattern [

	^ queryRunner pattern
]

{ #category : #accessing }
ToListElementSieve >> pattern: aPattern [

	queryRunner pattern: aPattern 
]

{ #category : #'selection command' }
ToListElementSieve >> removeIndexesSelectionCommand: aCommand [


]

{ #category : #'selection command' }
ToListElementSieve >> removeIntervalSelectionCommand: aCommand [


]

{ #category : #'selection command' }
ToListElementSieve >> removeWholeSelectionCommand: aCommand [


	
]
