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
	sieve := list dataAccessor newSieve.
	space deferAndSettle: [ space root addChild: list ]
]

{ #category : #accessing }
ToListElementSieveTest >> statesOfAmerica [

	^ { #Alabama. #Alaska. #Arizona. #Arkansas. #California. #Colorado.
		#Connecticut. #Delaware. #Florida. #Georgia. #Hawaii. #Idaho. #Illinois. #Indiana.
		#Iowa. #Kansas. #Kentucky. #Louisiana. #Maine. #Maryland. #Massachusetts.
		#Michigan. #Minnesota. #Mississippi. #Missouri. #Montana. #Nebraska.
		#Nevada. #'New Hampshire'. #'New Jersey'. #'New Mexico'.
		#'New York'. #'North Carolina'. #'North Dakota'. #Ohio. #Oklahoma.
		#Oregon. #'Pennsylvania Rhode Island'. #'South Carolina'.
		#'South Dakota'. #Tennessee. #Texas. #Utah. #Vermont. #Virginia.
		#Washington. #'West Virginia'. #Wisconsin. #Wyoming }
]

{ #category : #tests }
ToListElementSieveTest >> testCurrentData [
	" when data items are added through the data accessor, 
	original data (list element data source mirror) should be updated accordingly.
	When the sieve  has a pattern, the original data is untouched even the list data source is updated"

	| passedInHandler |
	space deferAndSettle: [
		sieve filter: [ :anInteger :aPattern |
			anInteger < aPattern asInteger ] ].
	self assert: sieve currentData isEmpty.

	space deferAndSettle: [ list dataAccessor addAll: (1 to: 10) ].
	passedInHandler := false.
	list dataSource addEventHandlerOn: ToCollectionSievedEvent doOnce: [
			passedInHandler := true.
			self assert: sieve currentData asArray equals: #( 1 2 3 4 ) ].

	space deferAndSettle: [ sieve pattern: '5' ].
	500 milliSeconds wait.
	space settle.
	self assert: passedInHandler.
	
	passedInHandler := false.
	list dataSource addEventHandlerOn: ToCollectionSievedEvent doOnce: [
			passedInHandler := true.
			self assert: sieve currentData asArray equals: #( 1 2 3 4 5 6 7 8 9 10) ].

	space deferAndSettle: [ sieve pattern: '' ].
	500 milliSeconds wait.
	space settle.
	self assert: passedInHandler
]

{ #category : #tests }
ToListElementSieveTest >> testIsInstalled [

	self assert: sieve isInstalled.

	space deferAndSettle: [ sieve onUninstalledIn: list ].
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
	space deferAndSettle: [ sieve onUninstalledIn: list ].
	self assert: sieve originalData isNil.
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
	space deferAndSettle: [
		sieve filter: [ :anInteger :aPattern |
			anInteger < aPattern asInteger ] ].
	self assert: sieve currentData isEmpty.

	space deferAndSettle: [ list dataAccessor addAll: (1 to: 10) ].
	self assert: sieve originalData size equals: 10.
	1 to: 10 do: [ :idx |
			self
				assert: (sieve originalData at: idx)
				equals: (list dataSource at: idx) ].

	space deferAndSettle: [ list dataAccessor add: 11 ].
	self assert: sieve originalData last equals: 11.
	passedInHandler := false.
	list dataSource addEventHandlerOn: ToCollectionSievedEvent do: [
			passedInHandler := true.
			self assert: sieve originalData size equals: 11.
			self assert: sieve currentData asArray equals: #( 1 2 3 4 ) ].

	space deferAndSettle: [ sieve pattern: '5' ].
	500 milliSeconds wait.
	space settle.
	self assert: passedInHandler
]

{ #category : #'tests - selection' }
ToListElementSieveTest >> testOriginalIndexMap [
	" when data items are added through the data accessor, 
	original data (list element data source mirror) should be updated accordingly.
	When the sieve  has a pattern, the original data is untouched even the list data source is updated"

	self assert: sieve originalIndexMap isEmpty.
	
	space deferAndSettle: [ list dataAccessor addAll: (1 to: 10) ].
	self assert: sieve originalIndexMap size equals: 10.
	1 to: 10 do: [ :idx |
			self
				assert: (sieve originalIndexMap at: idx)
				equals: (list dataSource at: idx) ].
			
	space deferAndSettle: [ list dataAccessor add: 11 ].
	self assert: (sieve originalIndexMap at: 11) equals: 11.
	
	space deferAndSettle: [ list dataAccessor removeFirst ].
	self assert: (sieve originalIndexMap at: 11) equals: 10.

	space deferAndSettle: [ list dataAccessor at: 1 put: 100 ].
	self assert: (sieve originalIndexMap at: 100) equals: 1.
]

{ #category : #'tests - selection' }
ToListElementSieveTest >> testOriginalIndexMapWhenDataAreAddedBeforeTheSieve [
	" when data items are added through the data accessor, 
	original data (list element data source mirror) should be updated accordingly.
	When the sieve  has a pattern, the original data is untouched even the list data source is updated.
	If the list element has data when the sieve is installed, then, the index map must be initialized correctly.
	"

	list := ToListElement new.
	space deferAndSettle: [
		space root addChild: list.
		list dataAccessor addAll: (1 to: 10).
		sieve := list dataAccessor newSieve ].
	self deny: sieve originalIndexMap isNil.
	self deny: sieve originalIndexMap isEmpty.
	
	self assert: sieve originalIndexMap size equals: 10.
	1 to: 10 do: [ :idx |
			self
				assert: (sieve originalIndexMap at: idx)
				equals: (list dataSource at: idx) ]
]

{ #category : #'tests - selection' }
ToListElementSieveTest >> testOriginalIndexMapWhenDataAreAddedBeforeTheSieve2 [
	" when data items are added through the data accessor, 
	original data (list element data source mirror) should be updated accordingly.
	When the sieve  has a pattern, the original data is untouched even the list data source is updated.
	If the list element has data when the sieve is installed, then, the index map must be initialized correctly.
	Here te list is added late in the space. The index map update occurs after the list is added in the space   "

	list := ToListElement new.
	space deferAndSettle: [
		list dataAccessor addAll: (1 to: 10).
		sieve := list dataAccessor newSieve ].
	self deny: sieve originalIndexMap isNil.
	self deny: sieve originalIndexMap isEmpty.
	self assert: sieve originalIndexMap size equals: 10.
	1 to: 10 do: [ :idx |
		self
			assert: (sieve originalIndexMap at: idx)
			equals: (list dataSource at: idx) ].
]

{ #category : #'tests - selection' }
ToListElementSieveTest >> testSelectionViaList [
	" the selecter can be used to select item programatically "

	space deferAndSettle: [ list dataAccessor addAll: self statesOfAmerica ].
	space deferAndSettle: [ list selecter selectOneMoreIndex: 3 ].
	self assert: sieve selectionModel selectedIndexes equals: #( 3 ).

	space deferAndSettle: [ sieve pattern: 'Alabama' ].
	500 milliSeconds wait.
	space settle.
	self assert: list dataAccessor size equals: 1.
	self assert: sieve selectionModel selectedIndexes equals: #( 3 ).
	self assert: list selectionModel selectedIndexes equals: #(  ).

	space deferAndSettle: [ sieve pattern: '' ].
	500 milliSeconds wait.
	space settle.
	self assert: sieve selectionModel selectedIndexes equals: #( 3 ).
	self assert: list selectionModel selectedIndexes equals: #( 3 )
]

{ #category : #'tests - selection' }
ToListElementSieveTest >> testSelectionViaList2 [
	" the selecter can be used to select item programatically "

	space deferAndSettle: [ list dataAccessor addAll: self statesOfAmerica ].
	" select California, Colorado and Connecticut "
	space deferAndSettle: [ list selecter selectIndex: 5 to: 7 ].
	self assert: sieve selectionModel selectedIndexes equals: #( 5 6 7 ).

	space deferAndSettle: [ sieve pattern: 'Alabama' ].
	500 milliSeconds wait.
	space settle.
	self assert: list dataAccessor size equals: 1.
	self assert: list selectionModel selectedIndexes equals: #(  ).

	space deferAndSettle: [ sieve pattern: 'C' ].
	500 milliSeconds wait.
	space settle.
	self assert: list selectionModel selectedIndexes equals: #( 1 2 3 ).

	space deferAndSettle: [ sieve pattern: 'Co' ].
	500 milliSeconds wait.
	space settle.
	self assert: list selectionModel selectedIndexes equals: #( 1 2 ).

	space deferAndSettle: [ sieve pattern: 'Col' ].
	500 milliSeconds wait.
	space settle.
	self assert: list selectionModel selectedIndexes equals: #( 1 ).
	self assert: list dataAccessor size equals: 1.
	self assert: list dataAccessor first equals: 'Colorado'
]

{ #category : #'tests - selection' }
ToListElementSieveTest >> testSelectionViaSelecter [
	" the selecter can be used to select item programatically "

	space deferAndSettle: [ list dataAccessor addAll: self statesOfAmerica ].
	space deferAndSettle: [ sieve selecter selectOneMoreIndex: 3 ].
	self assert: sieve selectionModel selectedIndexes equals: #( 3 ).

	space deferAndSettle: [ sieve pattern: 'Alabama' ].
	500 milliSeconds wait.
	space settle.
	self assert: list dataAccessor size equals: 1.
	self assert: sieve selectionModel selectedIndexes equals: #( 3 ).
	self assert: list selectionModel selectedIndexes equals: #(  ).

	space deferAndSettle: [ sieve pattern: '' ].
	500 milliSeconds wait.
	space settle.
	self assert: sieve selectionModel selectedIndexes equals: #( 3 ).
	self assert: list selectionModel selectedIndexes equals: #( 3 )
]
