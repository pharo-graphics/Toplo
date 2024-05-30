Class {
	#name : #ToListElementSieve,
	#superclass : #Object,
	#traits : 'TBlEventTarget + TToPrenotificationTarget',
	#classTraits : 'TBlEventTarget classTrait + TToPrenotificationTarget classTrait',
	#instVars : [
		'queryRunner',
		'originalData',
		'currentData',
		'selectionModel',
		'selecter',
		'selectionHandler',
		'sharedHandler',
		'eventDispatcher',
		'originalIndexMap',
		'sieveEventHandler',
		'commandEventHandler'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #accessing }
ToListElementSieve >> currentData [

	^ currentData 
]

{ #category : #enumerating }
ToListElementSieve >> currentDataWithLocalAndOriginalIndexDo: aBlock [
	" aBlock takes a data, its local index and its original index "

	self currentData withIndexDo: [ :d :localIndex |
		| originalIndex |
		originalIndex := originalIndexMap at: d.
		aBlock value: d value: localIndex value: originalIndex ]
]

{ #category : #enumerating }
ToListElementSieve >> currentDataWithOriginalIndexDo: aBlock [
	" aBlock takes a data an its index as arguments "

	self currentData do: [ :d |
		| idx |
		idx := originalIndexMap at: d.
		aBlock value: d value: idx ]
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

{ #category : #accessing }
ToListElementSieve >> isInstalled [

	^ originalData notNil
]

{ #category : #'api - hooks' }
ToListElementSieve >> onInstalledIn: aListElement [
	" install the sieve on the listElement "

	originalData ifNotNil: [
		^ (BlImmutableObjectChangeError object: self) signal ].
	originalIndexMap := IdentityDictionary new.
	selectionModel := aListElement selectionModel duplicate.

	originalData := aListElement dataAccessor newMirror.
	queryRunner := ToObservableCollectionFilter new.
	queryRunner onInstalledIn: originalData.

	" initialization of the current result with the current pattern "
	self updateCurrentData.
	sharedHandler := BlSharedEventDistributor new.
	sharedHandler shareEvents:
		{ ToObservableCollectionFilterResultEvent }.
	originalData addEventHandler: sharedHandler.
	aListElement addEventHandler: sharedHandler.

	selectionHandler := ToSievedListElementEventHandler new.
	selectionHandler sieve: self.
	aListElement addEventHandler: selectionHandler.

	sieveEventHandler := ToSieveEventHandler new
		                     listElement: aListElement;
		                     yourself.
	commandEventHandler := ToDirectCommandEventHandler new.
	selecter := ToCompositeSelecter new.
	selecter
		selectionModel: self selectionModel;
		operator: sieveEventHandler;
		enabled: true;
		multiple: aListElement isMultipleSelection.
	selecter onInstalledIn: self.

	self addEventHandler: sieveEventHandler.
	self addEventHandler: commandEventHandler
]

{ #category : #'api - hooks' }
ToListElementSieve >> onUninstalledIn: aListElement [
	" uninstall list element handlers and the queyrunner properly "

	aListElement removeEventHandler: selectionHandler.
	queryRunner onUninstalledIn: originalData.
	originalData removeEventHandler: sharedHandler.
	aListElement removeEventHandler: sharedHandler.
	self removeEventHandler: sieveEventHandler.
	self removeEventHandler: commandEventHandler.
	sieveEventHandler := nil.
	commandEventHandler := nil.
	sharedHandler := nil.
	originalData unmirrored.
	originalData := nil.
	currentData := nil.
	queryRunner := nil
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

	queryRunner
		pattern: aPattern
]

{ #category : #accessing }
ToListElementSieve >> selecter [ 

	^ selecter
]

{ #category : #accessing }
ToListElementSieve >> selectionModel [ 

	^ selectionModel
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
