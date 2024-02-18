Class {
	#name : #ToListElementSieve,
	#superclass : #Object,
	#instVars : [
		'queryRunner',
		'originalData',
		'originalDataUpdater',
		'originalIndexedData',
		'queryResultHandler',
		'queryApplicationTask',
		'currentResults'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #'event handling' }
ToListElementSieve >> applyObservableCollectionQueryResultEventFor: aListElement [
	" a query has occured (becuse the query pattern has changed), update the list element accordingly "

	" get the filtered data "
	self buildCurrentQueryResults.
	aListElement dataAccessor filterResult: (currentResults collect: [ :assoc | assoc key ]).
	aListElement dispatchEvent: (ToListSieveFilterAppliedEvent new
			 sieve: self;
			 yourself)
]

{ #category : #accessing }
ToListElementSieve >> buildCurrentQueryResults [

	currentResults := queryRunner pattern
		                       ifEmpty: [  originalIndexedData ]
		                       ifNotEmpty: [
			                       queryRunner selectedIndexes collect: [ :idx |
				                       originalIndexedData at: idx ] ]
]

{ #category : #private }
ToListElementSieve >> buildOriginalIndexedData [

	| assocs |
	assocs := Array streamContents: [ :str |
		          originalData withIndexDo: [ :d :i | str nextPut: d -> i ] ].
	originalIndexedData updateAllWith: assocs
]

{ #category : #accessing }
ToListElementSieve >> dataFilter: aValuable [
	" filter takes a data and a pattern as argument "

	queryRunner dataFilter: [ :assoc :pattern |
		aValuable value: assoc key value: pattern ]
]

{ #category : #'api - hooks' }
ToListElementSieve >> initializeOriginalDatafor: aListElement [
	
	originalData ifNotNil: [
		^ (BlImmutableObjectChangeError object: self) signal ].
	originalData := aListElement dataAccessor newMirror.

	" handler to update the original indexed data if the list element data contents change 
	** after ** the sieve installation"
	originalDataUpdater := BlEventHandler
		                       on: ToCollectionAfterChangeEvent
		                       do: [ :event |
		                       self onCollectionAfterChangeEvent: event for: aListElement ].
	originalData addEventHandler: originalDataUpdater.
	originalIndexedData := ToObservableCollection new.
	self buildOriginalIndexedData.

]

{ #category : #'event handling' }
ToListElementSieve >> onCollectionAfterChangeEvent: anEvent for: aListElement [

	aListElement selecter deselectAll.
	self buildOriginalIndexedData.
	self pattern
		ifNotEmpty: [ self pattern: '' ]
		ifEmpty: [ self buildCurrentQueryResults ]
]

{ #category : #'api - hooks' }
ToListElementSieve >> onInstalledIn: aListElement [
	" install the sieve on the listElement "

	self initializeOriginalDatafor: aListElement.

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
		                      self onObservableCollectionQueryResultEvent: event for: aListElement].
	originalIndexedData addEventHandler: queryResultHandler
]

{ #category : #'event handling' }
ToListElementSieve >> onObservableCollectionQueryResultEvent: anEvent for: aListElement [
	" a query has occured (becuse the query pattern has changed), 
	update the list element accordingly "

	queryApplicationTask ifNotNil: [
		aListElement dequeueTask: queryApplicationTask.
		queryApplicationTask := nil ].
	aListElement isAttachedToSceneGraph ifFalse: [
		self applyObservableCollectionQueryResultEventFor: aListElement.
		^ self ].
	queryApplicationTask := BlTaskAction new.
	queryApplicationTask action: [
		queryApplicationTask := nil.
		self applyObservableCollectionQueryResultEventFor: aListElement ].
	aListElement enqueueTask: queryApplicationTask
]

{ #category : #'api - hooks' }
ToListElementSieve >> onUninstalledIn: aListElement [
	" uninstall list element handlers and the queyrunner properly "

	queryRunner onUninstalledIn: originalIndexedData.
	originalData removeEventHandler: originalDataUpdater.
	originalIndexedData removeEventHandler: queryResultHandler.
	queryResultHandler := nil.
	originalIndexedData := nil.
	originalData := nil.
	currentResults := nil.
	queryRunner := nil.
	originalDataUpdater := nil.
	originalIndexedData := nil
]

{ #category : #accessing }
ToListElementSieve >> originalData [ 

	^ originalData 
]

{ #category : #accessing }
ToListElementSieve >> pattern [

	^ queryRunner pattern
]

{ #category : #accessing }
ToListElementSieve >> pattern: aPattern [

	queryRunner pattern: aPattern 
]
