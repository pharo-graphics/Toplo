Class {
	#name : #ToListElementSieve,
	#superclass : #Object,
	#instVars : [
		'queryRunner',
		'originalData',
		'currentResults',
		'listElement',
		'filterResultTask',
		'originalDataUpdater',
		'originalIndexedData',
		'queryResultHandler',
		'selectionChangedHandler',
		'currentSelectionModel'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #private }
ToListElementSieve >> buildOriginalIndexedData [

	| assocs |
	assocs := Array streamContents: [ :str |
		          originalData withIndexDo: [ :d :i | str nextPut: d -> i ] ].
	originalIndexedData updateAllWith: assocs
]

{ #category : #accessing }
ToListElementSieve >> currentResults [

	^ currentResults
]

{ #category : #accessing }
ToListElementSieve >> currentSelectedIndexes [

	^ currentSelectionModel indices
]

{ #category : #accessing }
ToListElementSieve >> dataFilter: aValuable [
	" filter takes a data and a pattern as argument "

	queryRunner dataFilter: [ :assoc : pattern | aValuable value: assoc key value: pattern ]
]

{ #category : #'event handling' }
ToListElementSieve >> onCollectionAfterChangeEvent: anEvent [

	listElement selectionStrategy deselectAll.
	self buildOriginalIndexedData
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

	" original selection maintains the original data selection up-to-date even with a filtered contents "
	currentSelectionModel := aListElement selectionStrategy newSelectionModel.
	currentSelectionModel selectAllIndexes: aListElement selectionStrategy selectedIndexes.
	
	" the query runner will run the query in background on the originalIndexedData collection "
	queryRunner := ToObservableCollectionQueryRunner new.
	queryRunner onInstalledIn: originalIndexedData.
	self dataFilter: queryRunner defaultFilter.

	" initialization of the current result with an empty pattern "
	currentResults := self results.

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

	| currentIndexes |
	currentIndexes := anEvent currentIndexes asSet.
	self pattern
		ifEmpty: [
			currentSelectionModel deselectAll.
			currentResults withIndexDo: [ :assoc :idx |
				(currentIndexes includes: idx) ifTrue: [
					currentSelectionModel selectIndex: assoc value ] ] ]
		ifNotEmpty: [
			currentResults withIndexDo: [ :assoc :idx |
				(currentIndexes includes: idx)
					ifTrue: [ currentSelectionModel selectIndex: assoc value ]
					ifFalse: [ currentSelectionModel deselectIndex: assoc value ] ] ].
	listElement dispatchEvent:
		(ToListElementSieveSelectionChangedEvent new
			 sieve: self;
			 yourself)
]

{ #category : #'event handling' }
ToListElementSieve >> onObservableCollectionQueryResultEvent: anEvent [

	| selectedIndexes |
	listElement isAttachedToSceneGraph ifTrue: [
		| space |
		space := listElement space.
		filterResultTask ifNotNil: [ space dequeueTask: filterResultTask ] ].

	currentResults := self results.
	queryRunner pattern
		ifEmpty: [ selectedIndexes := currentSelectionModel indices]
		ifNotEmpty: [
			selectedIndexes := Array streamContents: [ :stream |
				                   currentResults withIndexDo: [ :assoc :idx |
					                   (currentSelectionModel containsIndex: assoc value)
						                   ifTrue: [ stream nextPut: idx ] ] ]  ].

	"If the list element is attached, then,  task must be used here because the 
	filtering is runned asynchronously. The task allows to re-synchronise the element response 
	( and then to be runned in the UI thread ).
	As an example, it can avoid the children updating during layouting (because during layouting 
	children are temporarily detached - (which leads to errors related to children adding and 
	which are difficult to understand)"
	listElement isAttachedToSceneGraph ifTrue: [
		| space |
		space := listElement space.
		filterResultTask := BlTaskAction new.
		filterResultTask action: [
			self updateListElementWithSelectedIndexes: selectedIndexes.
			filterResultTask := nil ].
		space enqueueTask: filterResultTask.
		^ self ].
	self updateListElementWithSelectedIndexes: selectedIndexes
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
	listElement := nil.
	originalData := nil.
	currentResults := nil.
	queryRunner := nil.
	filterResultTask := nil.
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

{ #category : #accessing }
ToListElementSieve >> results [

	^ queryRunner pattern ifEmpty: [ originalIndexedData ] ifNotEmpty: [
		  Array streamContents: [ :stream |
			  queryRunner selectedIndexes do: [ :idx |
				  stream nextPut: (originalIndexedData at: idx) ] ] ]
]

{ #category : #'event handling' }
ToListElementSieve >> updateListElementWithSelectedIndexes: aCollectionOfIndexes [

	listElement data filterResult: (currentResults collect: [ :assoc | assoc key ]).
	listElement selectionStrategy selectOnlyIndexes: aCollectionOfIndexes.
	listElement dispatchEvent:
		(ToListElementSieveFilterAppliedEvent new
			 sieve: self;
			 yourself)
]
