Class {
	#name : #ToListElementSieve,
	#superclass : #Object,
	#instVars : [
		'queryRunner',
		'originalData',
		'queryResultHandler',
		'queryApplicationTask',
		'currentData',
		'selectionHandler'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #'event handling' }
ToListElementSieve >> applyObservableCollectionQueryResultEventFor: aListElement [
	" a query has occured (becuse the query pattern has changed), update the list element accordingly "

	self updateCurrentData.
	" update the list element "
	aListElement selecter beSilentWhile: [ :s | 
		aListElement dataAccessor filterResult: currentData ].
	" don't deselect here"
	"aListElement selecter deselectAll."
	aListElement dispatchEvent: (ToListSieveFilterAppliedEvent new
			 sieve: self;
			 yourself)
]

{ #category : #accessing }
ToListElementSieve >> dataFilter: aValuable [
	" filter takes a data and a pattern as argument "

	queryRunner dataFilter: [ :item :pattern |
		aValuable value: item value: pattern ]
]

{ #category : #'event handling' }
ToListElementSieve >> onCollectionAfterChangeEvent: anEvent for: aListElement [

	self pattern ifEmpty: [ aListElement selecter deselectAll ].
	self pattern
		ifNotEmpty: [ self pattern: '' ]
		ifEmpty: [ 	self updateCurrentData ]
]

{ #category : #'api - hooks' }
ToListElementSieve >> onInstalledIn: aListElement [
	" install the sieve on the listElement "

	originalData ifNotNil: [
		^ (BlImmutableObjectChangeError object: self) signal ].
	originalData := aListElement dataAccessor newMirror.
	queryRunner := ToObservableCollectionQueryRunner new.
	queryRunner onInstalledIn: originalData.

	" initialization of the current result with the current pattern "
	self updateCurrentData.

	" a filtering occured : put the new data in the list element "
	queryResultHandler := BlEventHandler
		                      on: ToObservableCollectionQueryResultEvent
		                      do: [ :event |
			                      self
				                      onObservableCollectionQueryResultEvent:
				                      event
				                      for: aListElement ].
	originalData addEventHandler: queryResultHandler.
	selectionHandler := ToListElementSieveSelectionEventHandler new
			 sieve: self;
			 yourself.
	aListElement addEventHandler: selectionHandler
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

	aListElement removeEventHandler: selectionHandler.
	queryRunner onUninstalledIn: originalData.
	originalData unmirrored.
	originalData removeEventHandler: queryResultHandler.
	queryResultHandler := nil.
	originalData := nil.
	currentData := nil.
	queryRunner := nil
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

{ #category : #private }
ToListElementSieve >> updateCurrentData [

	" get the filtered data "
	currentData := queryRunner pattern
		               ifEmpty: [ originalData ]
		               ifNotEmpty: [
			               queryRunner selectedIndexes collect: [ :idx |
				               originalData at: idx ] ].

]
