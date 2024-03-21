Class {
	#name : #ToListElementSieve2,
	#superclass : #Object,
	#instVars : [
		'queryRunner',
		'originalData',
		'currentData',
		'selectionHandler',
		'sharedHandler',
		'dataPositionIndex'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #accessing }
ToListElementSieve2 >> currentData [

	^ currentData 
]

{ #category : #enumerating }
ToListElementSieve2 >> currentDataWithIndexDo: aBlock [
	" aBlock takes a data an its index as arguments "

	self currentData do: [ :d |
		| idx |
		idx := self dataPositionIndex at: d.
		aBlock value: d value: idx ]
]

{ #category : #enumerating }
ToListElementSieve2 >> currentIndexesDo: aBlock [
	" aBlock takes an index as argument "

	self currentData do: [ :d |
		| idx |
		idx := self dataPositionIndex at: d.
		aBlock value: idx ]
]

{ #category : #accessing }
ToListElementSieve2 >> dataFilter: aValuable [
	" filter takes a data and a pattern as argument "

	queryRunner dataFilter: [ :item :pattern |
		aValuable value: item value: pattern ]
]

{ #category : #accessing }
ToListElementSieve2 >> dataPositionIndex [

	^ dataPositionIndex 
]

{ #category : #accessing }
ToListElementSieve2 >> isInstalled [

	^ originalData notNil
]

{ #category : #'api - hooks' }
ToListElementSieve2 >> onInstalledIn: aListElement [
	" install the sieve on the listElement "

	originalData ifNotNil: [
		^ (BlImmutableObjectChangeError object: self) signal ].
	dataPositionIndex := IdentityDictionary new.
	originalData := aListElement dataAccessor newMirror.
	queryRunner := ToObservableCollectionFilter new.
	queryRunner onInstalledIn: originalData.

	" initialization of the current result with the current pattern "
	self updateCurrentData.
	sharedHandler := BlSharedEventDistributor new.
	sharedHandler shareEvents: { ToObservableCollectionFilterResultEvent }.
	originalData addEventHandler: sharedHandler.
	aListElement addEventHandler: sharedHandler.

	selectionHandler := ToSievedListElementEventHandler new.
	selectionHandler sieve: self.
	aListElement addEventHandler: selectionHandler
]

{ #category : #'api - hooks' }
ToListElementSieve2 >> onUninstalledIn: aListElement [
	" uninstall list element handlers and the queyrunner properly "

	aListElement removeEventHandler: selectionHandler.
	queryRunner onUninstalledIn: originalData.
	originalData removeEventHandler: sharedHandler.
	aListElement removeEventHandler: sharedHandler.
	sharedHandler := nil.
	originalData unmirrored.
	originalData := nil.
	currentData := nil.
	queryRunner := nil
]

{ #category : #accessing }
ToListElementSieve2 >> originalData [ 

	^ originalData 
]

{ #category : #accessing }
ToListElementSieve2 >> pattern [

	^ queryRunner pattern
]

{ #category : #accessing }
ToListElementSieve2 >> pattern: aPattern [

	queryRunner
		pattern: aPattern
]

{ #category : #private }
ToListElementSieve2 >> updateCurrentData [

	" get the filtered data "
	currentData := queryRunner pattern
		               ifEmpty: [ originalData ]
		               ifNotEmpty: [
			               queryRunner selectedIndexes collect: [ :idx |
				               originalData at: idx ] ].

]
