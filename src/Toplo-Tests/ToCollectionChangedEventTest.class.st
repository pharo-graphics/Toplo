"
A ToCollectionChangedEventTest is a test class for testing the behavior of ToCollectionChangedEvent
"
Class {
	#name : #ToCollectionChangedEventTest,
	#superclass : #TestCase,
	#instVars : [
		'ocol'
	],
	#category : #'Toplo-Tests-Core-Collection'
}

{ #category : #running }
ToCollectionChangedEventTest >> setUp [ 

	super setUp.
	ocol := ToObservableCollection new.
]

{ #category : #tests }
ToCollectionChangedEventTest >> testAddEvent [

	| eventCount eventInterval |
	eventCount := 0.

	eventInterval := nil.
	ocol addEventHandler: (BlEventHandler
			 on: ToCollectionAddEvent
			 do: [ :event |
				 eventCount := eventCount + 1.
				 eventInterval := event interval ]).
	ocol add: 1.
	self assert: eventCount equals: 1.
	self assert: eventInterval equals: (1 to: 1).

	eventInterval := nil.
	ocol add: 2.
	self assert: eventCount equals: 2.
	self assert: eventInterval equals: (2 to: 2).
	ocol addAll: { 3. 4. 5 }.
	self assert: eventCount equals: 3.
	self assert: eventInterval equals: (3 to: 5)
]

{ #category : #tests }
ToCollectionChangedEventTest >> testFilterEvent [

	| eventCount  eventInterval |
	eventCount := 0.
	eventInterval := nil.
	ocol removeAll.
	ocol addEventHandler: (BlEventHandler
			 on: ToCollectionFilteredEvent
			 do: [ :event |
				 eventCount := eventCount + 1.
				 eventInterval := event interval ]).
	ocol addAll: (1 to: 100).
	self assert: ocol size equals: 100.

	ocol filterResult: (20 to: 40).
	self assert: eventCount equals: 1.
	self assert: eventInterval equals: (1 to: 21).
	self assert: ocol size equals: 21.

	ocol filterResult: (5 to: 10).
	self assert: eventCount equals: 2.
	self assert: eventInterval equals: (1 to: 6).
	self assert: ocol size equals: 6.

	ocol filterResult: (50 to: 100).
	self assert: eventCount equals: 3.
	self assert: eventInterval equals: (1 to: 51).
	self assert: ocol size equals: 51
]

{ #category : #tests }
ToCollectionChangedEventTest >> testRemoveEvent [

	| eventCount  eventInterval |
	eventCount := 0.
	eventInterval := nil.

	ocol addEventHandler: (BlEventHandler
			 on: ToCollectionRemoveEvent
			 do: [ :event |
				 eventCount := eventCount + 1.
				 eventInterval := event interval ]).
			
	ocol addAll: { 1. 2. 3. 4 }.
	ocol removeFirst.
	self assert: eventCount equals: 1.
	self assert: eventInterval equals: (1 to: 1).

	self assert: ocol size equals: 3.
	self assert: eventCount equals: 1.
	self assert: eventInterval equals: (1 to: 1).

	ocol removeAll.
	self assert: eventCount equals: 2.
	self assert: eventInterval equals: (1 to: 3)
]

{ #category : #tests }
ToCollectionChangedEventTest >> testUpdateAll [

	| eventCount eventInterval |
	eventCount := 0.
	eventInterval := nil.

	ocol addEventHandler: (BlEventHandler
			 on: ToCollectionAddEvent
			 do: [ :event | 
				 eventCount := eventCount + 1.
				 eventInterval := event interval ]).
	ocol addAll: (1 to: 100).
	self assert: ocol size equals: 100.

	ocol updateAllWith: (101 to: 200).
	self assert: ocol size equals: 100.
	self assert: eventCount equals: 2.
	self assert: eventInterval equals: (1 to: 100).
	
	eventInterval := nil.
	ocol updateAllWith: (201 to: 300).
	self assert: ocol size equals: 100.
	self assert: eventCount equals: 3.
	self assert: eventInterval equals: (1 to: 100)
]

{ #category : #tests }
ToCollectionChangedEventTest >> testUpdateEvent [

	| eventCount eventInterval |
	eventCount := 0.
	eventInterval := nil.

	ocol addEventHandler: (BlEventHandler
			 on: ToCollectionUpdateEvent
			 do: [ :event |
				 eventCount := eventCount + 1.
				 eventInterval := event interval ]).
	ocol addAll: (1 to: 100).
	self assert: ocol size equals: 100.

	ocol at: 2 put: 20.
	self assert: eventCount equals: 1.
	self assert: eventInterval equals: (2 to: 2).

	eventInterval := nil.
	ocol at: 2 put: 30.
	self assert: eventCount equals: 2.
	self assert: eventInterval equals: (2 to: 2).

	eventInterval := nil.
	ocol replaceFrom: 10 to: 20 with: (10 to: 20).
	self assert: eventCount equals: 3.
	self assert: eventInterval equals: (10 to: 20)
]
