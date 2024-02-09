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
		'currentSelection'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

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
	originalIndexedDataArray := originalIndexedData asArray
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

{ #category : #'api - hooks' }
ToListElementSieve >> onInstalledIn: aListElement [
	" install the sieve on the listElement "

	listElement := aListElement.

	originalData ifNotNil: [
		^ (BlImmutableObjectChangeError object: self) signal ].
	originalData := aListElement data newMirror.
	originalIndexedData := ToObservableCollection new.

	" handler to update the original indexed data if the list element data contents change 
	** after ** the sieve installation"
	originalDataUpdater := BlEventHandler
		                       on: ToCollectionAfterChangeEvent
		                       do: [ :event |
		                       self onCollectionAfterChangeEvent: event ].
	originalData addEventHandler: originalDataUpdater.
	self buildOriginalIndexedData.

	" currentSelectionModel maintains the original data selection up-to-date even with a filtered contents "
	currentSelection := BlCompositeSelection new.
	currentSelection selectAllIndexes: aListElement selectionModel selectedIndexes.
	
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
			 do: [ :event | self onObservableCollectionQueryResultEvent: event ].
	originalIndexedData addEventHandler: queryResultHandler.

	" a selection occurs in the list element. Have to report it in the originalSelection "
	selectionChangedHandler := BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | self onListSelectionChangedEvent: event ].
	aListElement addEventHandler: selectionChangedHandler
]

{ #category : #'event handling' }
ToListElementSieve >> onListSelectionChangedEvent: anEvent [

	| currentIndexes selectedStream deselectedStream |

	currentIndexes := anEvent selectedIndexes asSet.
	selectedStream := WriteStream on: (Array new: 10).
	deselectedStream := WriteStream on: (Array new: 10).

	self pattern
		ifEmpty: [
			currentResultsArray withIndexDo: [ :assoc :idx |
				(currentIndexes includes: idx) ifTrue: [
					selectedStream nextPut: assoc value ] ] ]
		ifNotEmpty: [
			currentResultsArray withIndexDo: [ :assoc :idx |
				(currentIndexes includes: idx)
					ifTrue: [ selectedStream nextPut: assoc value ]
					ifFalse: [ deselectedStream nextPut: assoc value ] ] ].

	currentSelection deselectAllIndexes: deselectedStream contents.
	currentSelection selectAllIndexes: selectedStream contents.

	listElement dispatchEvent:
		(ToListElementSieveSelectionChangedEvent new
			 sieve: self;
			 yourself)
]

{ #category : #'event handling' }
ToListElementSieve >> onObservableCollectionQueryResultEvent: anEvent [

	" a query has occured (becuse the query pattern has changed), update the list element accordingly "

	| selectedIndexes |
	" get the filtered data "
	self buildCurrentQueryResults.
	" now the selected indexes "
	selectedIndexes := queryRunner pattern
		             ifEmpty: [ currentSelection indices]
		             ifNotEmpty: [Array streamContents: [ :stream |
				                   currentResultsArray withIndexDo: [ :assoc :idx |
					                   (currentSelection containsIndex: assoc value)
						                   ifTrue: [ stream nextPut: idx ] ] ] ].
   "Update litElement data together with the selection "
	listElement data filterResult: (currentResultsArray collect: [ :assoc | assoc key ]).
	listElement selecter selectOnlyIndexes: selectedIndexes.
	listElement dispatchEvent: (ToListElementSieveFilterAppliedEvent new
			 sieve: self;
			 yourself)
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
	listElement := nil.
	originalData := nil.
	currentResultsArray := nil.
	queryRunner := nil.
	originalDataUpdater := nil.
	originalIndexedData := nil
]

{ #category : #accessing }
ToListElementSieve >> pattern [

	^ queryRunner pattern
]

{ #category : #accessing }
ToListElementSieve >> pattern: aPattern [

	queryRunner pattern: aPattern 
]
