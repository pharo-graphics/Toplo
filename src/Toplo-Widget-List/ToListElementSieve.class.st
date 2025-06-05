Class {
	#name : #ToListElementSieve,
	#superclass : #Object,
	#traits : 'TBlEventTarget + TToAuthorisationRequestTarget',
	#classTraits : 'TBlEventTarget classTrait + TToAuthorisationRequestTarget classTrait',
	#instVars : [
		'queryRunner',
		'originalData',
		'currentData',
		'selecter',
		'eventDispatcher',
		'originalIndexMap',
		'dataSourceHandler',
		'sieveHandler',
		'listElementHandler'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #accessing }
ToListElementSieve >> currentData [

	^ currentData 
]

{ #category : #accessing }
ToListElementSieve >> dataFilter: aValuable [
	" filter takes a data and a pattern as argument "

	queryRunner dataFilter: [ :item :pattern |
		aValuable value: item value: pattern ]
]

{ #category : #'event management accessing' }
ToListElementSieve >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #initialization }
ToListElementSieve >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self
]

{ #category : #'api - hooks' }
ToListElementSieve >> installQueryRunnerIn: aListElement [
	" the query is applied on the original data.
	As a data source mirror, it works as follow:
		- when data are added/removed in/from the data source, 
			then the mirror is updated accordingly.
		- when data is filtered, the data source is initialized 
			with the filtered data but the mirror stays untouched 
			(see TToObservableCollection>>onSievedWith:"

	originalData := aListElement dataSource newMirror.
	currentData := originalData.
	queryRunner onInstalledIn: originalData.
	" When a query has occured (because the query pattern has changed), update the list element accordingly then
	 ask the list to process the appropiate data source command and to update the selection model.
	A task must be used to avoid that the list update occurs during the BlSpaceFrameEventPhase  
	 which can cause an issue because the layout must be launched each time a sieve result occurs "
	originalData
		addEventHandlerOn: ToObservableCollectionFilterAppliedEvent
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
ToListElementSieve >> newQueryRunner [

	^ ToObservableCollectionFilter new
]

{ #category : #'api - hooks' }
ToListElementSieve >> newSievedListDataSourceEventHandler [

	^ ToSievedListDataSourceEventHandler new
]

{ #category : #'api - hooks' }
ToListElementSieve >> newSievedListElementEventHandler [

	^ ToSievedListElementEventHandler new
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

	| selectionModel |
	originalData ifNotNil: [
		^ (BlImmutableObjectChangeError object: self) signal ].
	
	originalIndexMap := IdentityDictionary new.
	selectionModel := aListElement selectionModel copy.
	" selectionChangedEventClass: is needed to update the selection 
	of the list when the selecter is used programmatically.
	This is the case when a tag with a remove button in a ToSelect 
	is removed as a consequence of a click on the remove button of the tag "
	selecter := ToSieveSelecter new
		            selectionModel: selectionModel;
		            selectionChangedEventClass:
			            ToListPrimarySelectionChangedEvent;
		            multiple: aListElement isMultipleSelection;
		            yourself.
	selecter onInstalledIn: self.

	queryRunner := self newQueryRunner.
	self installQueryRunnerIn: aListElement.

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

	aListElement removeEventHandler: listElementHandler.
	aListElement dataSource removeEventHandler: dataSourceHandler.
	self uninstallQueryRunnerIn: aListElement.
	self removeEventHandler: sieveHandler.
	selecter onUninstalledIn: self.
	selecter := nil.
	listElementHandler := nil.
	dataSourceHandler := nil.
	sieveHandler := nil.
	currentData := nil.
	queryRunner := nil.
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

	^ queryRunner pattern
]

{ #category : #accessing }
ToListElementSieve >> pattern: aPattern [

	queryRunner pattern: aPattern.
	self dispatchEvent: (ToSievePatternChangedEvent new
			 sieve: self;
			 yourself)
]

{ #category : #accessing }
ToListElementSieve >> selectedIndexes [

	^ queryRunner selectedIndexes

	
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
ToListElementSieve >> uninstallQueryRunnerIn: aListElement [

	queryRunner onUninstalledIn: originalData.
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
