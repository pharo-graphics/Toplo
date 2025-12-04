"
I manage the possibility to keep a selection while filtering it. 
For example in a method list, the user selects some the initialize methods, then filter the list based on the init pattern, he/she will see the previously selected initialize methods. 

I'm using `ToObservableCollectionFilterApplier`.  
"
Class {
	#name : #ToListElementSieve,
	#superclass : #Object,
	#traits : 'TBlEventTarget + TToRequestTarget',
	#classTraits : 'TBlEventTarget classTrait + TToRequestTarget classTrait',
	#instVars : [
		'originalData',
		'currentData',
		'selecter',
		'eventDispatcher',
		'originalIndexMap',
		'dataSourceHandler',
		'sieveHandler',
		'listElementHandler',
		'filterApplier'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #'private - commands' }
ToListElementSieve >> addedDataSourceCommand: aCommand [
]

{ #category : #accessing }
ToListElementSieve >> currentData [

	^ currentData 
]

{ #category : #'event management accessing' }
ToListElementSieve >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #accessing }
ToListElementSieve >> filter: aValuable [
	" filter takes a data and a pattern as argument "

	filterApplier filter: [ :item :pattern |
		aValuable value: item value: pattern ]
]

{ #category : #initialization }
ToListElementSieve >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self
]

{ #category : #'api - hooks' }
ToListElementSieve >> installFilterApplierIn: aListElement [
	" the query is applied on the original data.
	As a data source mirror, it works as follow:
		- when data are added/removed in/from the data source, 
			then the mirror is updated accordingly.
		- when data is filtered, the data source is initialized 
			with the filtered data but the mirror stays untouched 
			(see TToObservableCollection>>onSievedWith:"

	originalData := aListElement dataSource newMirror.
	currentData := originalData.
	filterApplier onInstalledIn: originalData.
	" When a query has occured (because the query pattern has changed), update the list element accordingly then
	 ask the list to process the appropiate data source command and to update the selection model.
	A task must be used to avoid that the list update occurs during the BlSpaceFrameEventPhase  
	 which can cause an issue because the layout must be launched each time a sieve result occurs "
	originalData
		addEventHandlerOn: ToObservableCollectionFilterApplierEvent
		do: [ :event |
				self observableCollectionFilterAppliedEvent: event.
				aListElement enqueueTask:
					(BlTaskAction new action: [ aListElement onSievedWith: self ]) ]
]

{ #category : #accessing }
ToListElementSieve >> isInstalled [

	^ originalData notNil
]

{ #category : #private }
ToListElementSieve >> itemCount [ 

	^ currentData size
]

{ #category : #initialization }
ToListElementSieve >> newFilterApplier [

	^ ToObservableCollectionFilterApplier new
]

{ #category : #'api - hooks' }
ToListElementSieve >> newSievedListDataSourceEventHandler [

	^ ToSievedListDataSourceEventHandler new
]

{ #category : #'api - hooks' }
ToListElementSieve >> newSievedListElementEventHandler [

	^ ToSievedListElementEventHandler new
]

{ #category : #'instance creation' }
ToListElementSieve >> newTextField [ 

	^ ToTextField newForSieve: self
]

{ #category : #private }
ToListElementSieve >> observableCollectionFilterAppliedEvent: anEvent [

	currentData := anEvent pattern
		               ifEmpty: [ originalData ]
		               ifNotEmpty: [
		               anEvent selectedIndexes collect: [ :idx |
			               originalData at: idx ] ]
]

{ #category : #'api - hooks' }
ToListElementSieve >> onInstalledIn: aListElement [
	" install the sieve on the listElement "

	originalData ifNotNil: [
		^ (BlImmutableObjectChangeError object: self) signal ].
	originalIndexMap := IdentityDictionary new.

	selecter := aListElement selecter newSieveSelecter.
	selecter onInstalledIn: self.

	filterApplier := self newFilterApplier.
	self installFilterApplierIn: aListElement.

	listElementHandler := self newSievedListElementEventHandler.
	listElementHandler sieve: self.
	aListElement addEventHandler: listElementHandler.

	dataSourceHandler := self newSievedListDataSourceEventHandler.
	dataSourceHandler sieve: self.
	dataSourceHandler listElement: aListElement.
	aListElement dataSource addEventHandler: dataSourceHandler.

	sieveHandler := ToSieveEventHandler new
		                     listElement: aListElement;
		                     yourself.

	self addEventHandler: sieveHandler
]

{ #category : #'api - hooks' }
ToListElementSieve >> onUninstalledIn: aListElement [
	" uninstall list element handlers and the queyrunner properly "

	" one have to consume commands that could have been postponed "
	aListElement consumeFinalStepCommands.
	aListElement removeEventHandler: listElementHandler.
	aListElement dataSource removeEventHandler: dataSourceHandler.
	self uninstallFilterApplierIn: aListElement.
	self removeEventHandler: sieveHandler.
	selecter onUninstalledIn: self.
	selecter := nil.
	listElementHandler := nil.
	dataSourceHandler := nil.
	sieveHandler := nil.
	currentData := nil.
	filterApplier := nil.
	originalIndexMap := nil
]

{ #category : #accessing }
ToListElementSieve >> originalData [ 

	^ originalData 
]

{ #category : #accessing }
ToListElementSieve >> originalIndexMap [

	^ originalIndexMap 
]

{ #category : #accessing }
ToListElementSieve >> originalIndexOf: anObject [

	^ originalIndexMap at: anObject ifAbsent: [  ]
]

{ #category : #accessing }
ToListElementSieve >> pattern [

	^ filterApplier pattern
]

{ #category : #accessing }
ToListElementSieve >> pattern: aPattern [

	filterApplier pattern: aPattern.
	self dispatchEvent: (ToSievePatternChangedEvent new
			 sieve: self;
			 yourself)
]

{ #category : #accessing }
ToListElementSieve >> selectedIndexes [

	^ filterApplier selectedIndexes

	
]

{ #category : #accessing }
ToListElementSieve >> selecter [ 

	^ selecter
]

{ #category : #accessing }
ToListElementSieve >> selectionModel [ 

	^ selecter selectionModel
]

{ #category : #'api - hooks' }
ToListElementSieve >> uninstallFilterApplierIn: aListElement [

	filterApplier onUninstalledIn: originalData.
	originalData unmirrored.
	originalData := nil.

]

{ #category : #'selection updating' }
ToListElementSieve >> updateAllSelections [
]

{ #category : #enumerating }
ToListElementSieve >> withLocalAndOriginalIndexDo: aBlock [
	" aBlock takes a data, its local index and its original index "

	self currentData withIndexDo: [ :d :localIndex |
		| originalIndex |
		originalIndex := originalIndexMap at: d.
		aBlock value: d value: localIndex value: originalIndex ]
]

{ #category : #enumerating }
ToListElementSieve >> withOriginalIndexDo: aBlock [
	" aBlock takes a data an its index as arguments "

	self currentData do: [ :d |
		| idx |
		idx := originalIndexMap at: d.
		aBlock value: d value: idx ]
]
