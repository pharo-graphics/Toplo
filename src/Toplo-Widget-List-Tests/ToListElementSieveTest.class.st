"
A ToListElementSieveTest is a test class for testing the behavior of ToListElementSieve
"
Class {
	#name : #ToListElementSieveTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'list',
		'sieve'
	],
	#category : #'Toplo-Widget-List-Tests-Sieve'
}

{ #category : #running }
ToListElementSieveTest >> setUp [
	super setUp.
	list := ToListElement new.
	sieve := list newSieve.
	sieve onInstalledIn: list.
	space root addChild: list
]

{ #category : #tests }
ToListElementSieveTest >> testCurrentData [
	" when data items are added through the data accessor, 
	original data (list element data source mirror) should be updated accordingly.
	When the sieve  has a pattern, the original data is untouched even the list data source is updated"

	| passedInHandler |
	sieve dataFilter: [ :anInteger :aPattern |
		anInteger < aPattern asInteger ].
	self assert: sieve currentData isEmpty.
	list dataAccessor addAll: (1 to: 10).
	passedInHandler := false.
	list dataSource addEventHandlerOn: ToCollectionSievedEvent doOnce: [
			passedInHandler := true.
			self assert: sieve currentData asArray equals: #( 1 2 3 4 ) ].
	sieve pattern: '5'.
	500 milliSeconds wait.
	self waitTestingSpaces.
	self assert: passedInHandler.
	
	passedInHandler := false.
	list dataSource addEventHandlerOn: ToCollectionSievedEvent doOnce: [
			passedInHandler := true.
			self assert: sieve currentData asArray equals: #( 1 2 3 4 5 6 7 8 9 10) ].
	sieve pattern: ''.
	500 milliSeconds wait.
	self waitTestingSpaces.
	self assert: passedInHandler.
	

]

{ #category : #tests }
ToListElementSieveTest >> testIsInstalled [

	self assert: sieve isInstalled.
	sieve onUninstalledIn: list.
	self deny: sieve isInstalled
]

{ #category : #tests }
ToListElementSieveTest >> testOnInstalledIn [

	| handlers |
	self assert: sieve originalData notNil.
	self assert: (sieve originalData isKindOf: ToCollectionMirror).
	self assert: sieve originalData mirrored equals: list dataSource.
	self assert: sieve currentData identicalTo: sieve originalData.
	self assert: sieve selectionModel equals: list selectionModel.
	self assert: sieve selecter notNil.
	self assert: sieve originalIndexMap notNil.
	self deny: sieve selectionModel identicalTo: list selectionModel.
	
	handlers := sieve eventDispatcher handlers.
	self
		assert:
		(handlers select: [ :h | h isKindOf: ToSieveEventHandler ]) size
		equals: 1	.
	handlers := list dataSource eventDispatcher handlers.
	self
		assert:
		(handlers select: [ :h | h isKindOf: ToSievedListDataSourceEventHandler ]) size
		equals: 1.
	handlers := list eventDispatcher handlers.
	self
		assert:
		(handlers select: [ :h | h isKindOf: ToSievedListElementEventHandler ]) size
		equals: 1
]

{ #category : #tests }
ToListElementSieveTest >> testOnInstalledInTwiceRaiseError [

	self
		should: [ sieve onInstalledIn: list ]
		raise: BlImmutableObjectChangeError
]

{ #category : #tests }
ToListElementSieveTest >> testOnUninstalledIn [

	| handlers |
	sieve onUninstalledIn: list.
	self assert: sieve originalData isNil.
	self assert: sieve selectionModel isNil.
	self assert: sieve selecter isNil.
	self assert: sieve originalIndexMap isNil.
	self assert: sieve currentData isNil.

	handlers := sieve eventDispatcher handlers.
	self
		assert:
		(handlers select: [ :h | h isKindOf: ToSieveEventHandler ]) size
		equals: 0	.
	handlers := list dataSource eventDispatcher handlers.
	self
		assert:
		(handlers select: [ :h | h isKindOf: ToSievedListDataSourceEventHandler ]) size
		equals: 0.
	handlers := list eventDispatcher handlers.
	self
		assert:
		(handlers select: [ :h | h isKindOf: ToSievedListElementEventHandler ]) size
		equals: 0
]

{ #category : #tests }
ToListElementSieveTest >> testOriginalData [
	" when data items are added through the data accessor, 
	original data (list element data source mirror) should be updated accordingly.
	When the sieve  has a pattern, the original data is untouched even the list data source is updated"

	| passedInHandler |
	sieve dataFilter: [ :anInteger :aPattern |
		anInteger < aPattern asInteger ].
	self assert: sieve currentData isEmpty.
	list dataAccessor addAll: (1 to: 10).
	self assert: sieve originalData size equals: 10.
	1 to: 10 do: [ :idx |
			self
				assert: (sieve originalData at: idx)
				equals: (list dataSource at: idx) ].
	list dataAccessor add: 11.
	self assert: sieve originalData last equals: 11.
	passedInHandler := false.
	list dataSource addEventHandlerOn: ToCollectionSievedEvent do: [
			passedInHandler := true.
			self assert: sieve originalData size equals: 11.
			self assert: sieve currentData asArray equals: #( 1 2 3 4 ) ].
	sieve pattern: '5'.
	500 milliSeconds wait.
	self waitTestingSpaces.
	self assert: passedInHandler
]
