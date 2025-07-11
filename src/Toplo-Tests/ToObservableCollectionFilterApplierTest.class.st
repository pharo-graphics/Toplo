"
A ToObservableCollectionFilterTest is a test class for testing the behavior of ToObservableCollectionFilter
"
Class {
	#name : #ToObservableCollectionFilterApplierTest,
	#superclass : #TestCase,
	#instVars : [
		'filter',
		'observableCollection'
	],
	#category : #'Toplo-Tests-Core-Collection'
}

{ #category : #running }
ToObservableCollectionFilterApplierTest >> setUp [ 

	super setUp.
	observableCollection := ToObservableCollection new.
	filter := ToObservableCollectionFilterApplier new.
	filter onInstalledIn: observableCollection.


]

{ #category : #tests }
ToObservableCollectionFilterApplierTest >> testNotifySelectedIndexesIn [

	| selectedIndexes pattern passedInHandler |
	observableCollection
		addEventHandlerOn: ToObservableCollectionFilterApplierEvent
		do: [ :event |
				passedInHandler := true.
				selectedIndexes := event selectedIndexes.
				pattern := event pattern ].
	observableCollection add: 'X'.

	passedInHandler := false.
	filter pattern: 'X'.
	500 milliSeconds wait.
	self assert: passedInHandler.
	self assert: selectedIndexes size equals: 1.
	self assert: selectedIndexes first equals: 1.
	self assert: pattern equals: 'X'.

	passedInHandler := false.
	filter pattern: 'Y'.
	500 milliSeconds wait.
	self assert: passedInHandler.
	self assert: selectedIndexes size equals: 0.
	self assert: pattern equals: 'Y'.

	passedInHandler := false.
	observableCollection add: 'YY'.
	filter pattern: 'YY'.
	500 milliSeconds wait.
	self assert: passedInHandler.
	self assert: selectedIndexes size equals: 1.
	self assert: selectedIndexes first equals: 2.
	self assert: pattern equals: 'YY'
]

{ #category : #tests }
ToObservableCollectionFilterApplierTest >> testNotifySelectedIndexesInEmptyCollection [

	| selectedIndexes pattern passedInHandler |
	passedInHandler := false.
	observableCollection addEventHandlerOn: ToObservableCollectionFilterApplierEvent
		doOnce: [ :event |
			passedInHandler := true.
			selectedIndexes :=  event selectedIndexes.
			pattern := event pattern ].
	filter pattern: 'X'.
	500 milliSeconds wait.
	self assert: passedInHandler.
	self assert: selectedIndexes isEmpty.
	self assert: pattern equals: 'X'
	
]

{ #category : #tests }
ToObservableCollectionFilterApplierTest >> testOnInstalledIn [ 

	self assert: filter semaphore notNil.
	self assert: filter process notNil.
	self assert: filter process isWaiting.
	self assert: filter delay equals: filter defaultDelay.
	self assert: filter filter notNil
]

{ #category : #tests }
ToObservableCollectionFilterApplierTest >> testOnUninstalledIn [ 

	filter onUninstalledIn: observableCollection.
	self assert: filter semaphore isNil.
	self assert: filter process isTerminated 
]

{ #category : #tests }
ToObservableCollectionFilterApplierTest >> testPattern [

	filter pattern: 'X'.
	self assert: filter pattern equals: 'X'.
	filter pattern: '  X  '.
	self assert: filter pattern equals: 'X'
]

{ #category : #tests }
ToObservableCollectionFilterApplierTest >> testPatternWhenCollectionChanged [

	|   passedInHandler |
	observableCollection
		addEventHandlerOn: ToObservableCollectionFilterApplierEvent
		do: [ :event |
				passedInHandler := true ].
	observableCollection add: 'X'.

	passedInHandler := false.
	filter pattern: 'X'.
	500 milliSeconds wait.
	self assert: passedInHandler.
	
	observableCollection add: 'X'.
	passedInHandler := false.
	filter pattern: 'X'.
	500 milliSeconds wait.
	self assert: passedInHandler.
	
	observableCollection at: 2 put: 'Y'.
	passedInHandler := false.
	filter pattern: 'X'.
	500 milliSeconds wait.
	self assert: passedInHandler.

	observableCollection removeAt: 1.
	passedInHandler := false.
	filter pattern: 'X'.
	500 milliSeconds wait.
	self assert: passedInHandler.




]

{ #category : #tests }
ToObservableCollectionFilterApplierTest >> testSamePatternTwice [

	| selectedIndexes pattern passedInHandler |
	observableCollection
		addEventHandlerOn: ToObservableCollectionFilterApplierEvent
		do: [ :event |
				passedInHandler := true.
				selectedIndexes := event selectedIndexes.
				pattern := event pattern ].
	observableCollection add: 'X'.

	passedInHandler := false.
	filter pattern: 'X'.
	500 milliSeconds wait.
	self assert: passedInHandler.
	self assert: selectedIndexes size equals: 1.
	self assert: selectedIndexes first equals: 1.
	self assert: pattern equals: 'X'.
	
	passedInHandler := false.
	filter pattern: 'X'.
	500 milliSeconds wait.
	self deny: passedInHandler

]
