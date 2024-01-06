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
ToCollectionChangedEventTest >> testAddRequestAddEvent [

	| validate requestCount eventCount candidates reqInterval eventInterval |
	validate := true.
	candidates := #(  ).
	requestCount := 0.
	eventCount := 0.
	reqInterval := nil.
	eventInterval := nil.
	ocol addEventHandler: (BlEventHandler
			 on: ToCollectionAddRequest
			 do: [ :request |
				 requestCount := requestCount + 1.
				 candidates := request candidates.
				 reqInterval := request interval.
				 request accepted: validate ]).
	ocol addEventHandler: (BlEventHandler
			 on: ToCollectionAddEvent
			 do: [ :event |
				 eventCount := eventCount + 1.
				 eventInterval := event interval ]).
	ocol add: 1.
	self assert: requestCount equals: 1.
	self assert: candidates size equals: 1.
	self assert: candidates first equals: 1.
	self assert: eventCount equals: 1.
	self assert: reqInterval equals: (1 to: 1).
	self assert: eventInterval equals: (1 to: 1).
	validate := false.
	reqInterval := nil.
	eventInterval := nil.
	ocol add: 2.
	self assert: requestCount equals: 2.
	self assert: eventCount equals: 1.
	self assert: reqInterval equals: (2 to: 2).
	self assert: eventInterval isNil.
	validate := true.
	ocol addAll: { 3. 4. 5 }.
	self assert: candidates equals: #( 3 4 5 ).
	self assert: requestCount equals: 3.
	self assert: eventCount equals: 2.
	self assert: reqInterval equals: (2 to: 4).
	self assert: eventInterval equals: (2 to: 4)
]

{ #category : #tests }
ToCollectionChangedEventTest >> testFilterRequestFilterEvent [

	| validate requestCount eventCount reqInterval eventInterval |
	validate := true.
	requestCount := 0.
	eventCount := 0.
	reqInterval := nil.
	eventInterval := nil.
	ocol addEventHandler: (BlEventHandler
			 on: ToCollectionFilterRequest
			 do: [ :request |
				 requestCount := requestCount + 1.
				 reqInterval := request interval.
				 request accepted: validate ]).
	ocol addEventHandler: (BlEventHandler
			 on: ToCollectionFilterEvent
			 do: [ :event |
				 eventCount := eventCount + 1.
				 eventInterval := event interval ]).
	ocol addAll: (1 to: 100).
	self assert: ocol size equals: 100.

	ocol filterResult: (20 to: 40).
	self assert: requestCount equals: 1.
	self assert: eventCount equals: 1.
	self assert: reqInterval equals: (1 to: 100).
	self assert: eventInterval equals: (1 to: 21).
	self assert: ocol size equals: 21.

	validate := false.
	ocol filterResult: (5 to: 10).
	self assert: requestCount equals: 2.
	self assert: eventCount equals: 1.
	self assert: reqInterval equals: (1 to: 21).
	self assert: eventInterval equals: (1 to: 21).
	self assert: ocol size equals: 21.

	validate := true.
	ocol filterResult: (50 to: 100).
	self assert: requestCount equals: 3.
	self assert: eventCount equals: 2.
	self assert: reqInterval equals: (1 to: 21).
	self assert: eventInterval equals: (1 to: 51).
	self assert: ocol size equals: 51
]

{ #category : #tests }
ToCollectionChangedEventTest >> testRemoveRequestRemoveEvent [

	| validate requestCount eventCount reqInterval eventInterval |
	validate := true.
	requestCount := 0.
	eventCount := 0.
	reqInterval := nil.
	eventInterval := nil.
	ocol addEventHandler: (BlEventHandler
			 on: ToCollectionRemoveRequest
			 do: [ :request |
				 requestCount := requestCount + 1.
				 reqInterval := request interval.
				 request accepted: validate ]).
	ocol addEventHandler: (BlEventHandler
			 on: ToCollectionRemoveEvent
			 do: [ :event |
				 eventCount := eventCount + 1.
				 eventInterval := event interval ]).
	ocol addAll: { 1. 2. 3. 4 }.
	ocol removeFirst.
	self assert: requestCount equals: 1.
	self assert: eventCount equals: 1.
	self assert: reqInterval equals: (1 to: 1).
	self assert: eventInterval equals: (1 to: 1).
	validate := false.
	self assert: ocol size equals: 3.
	ocol removeFirst.
	self assert: ocol size equals: 3.
	self assert: requestCount equals: 2.
	self assert: eventCount equals: 1.
	self assert: reqInterval equals: (1 to: 1).
	self assert: eventInterval equals: (1 to: 1).
	validate := true.
	ocol removeAll.
	self assert: requestCount equals: 3.
	self assert: eventCount equals: 2.
	self assert: reqInterval equals: (1 to: 3).
	self assert: eventInterval equals: (1 to: 3)
]

{ #category : #tests }
ToCollectionChangedEventTest >> testUpdateRequestUpdateEvent [

	| validate requestCount eventCount reqInterval eventInterval |
	validate := true.
	requestCount := 0.
	eventCount := 0.
	reqInterval := nil.
	eventInterval := nil.
	ocol addEventHandler: (BlEventHandler
			 on: ToCollectionUpdateRequest
			 do: [ :request |
				 requestCount := requestCount + 1.
				 reqInterval := request interval.
				 request accepted: validate ]).
	ocol addEventHandler: (BlEventHandler
			 on: ToCollectionUpdateEvent
			 do: [ :event |
				 eventCount := eventCount + 1.
				 eventInterval := event interval ]).
	ocol addAll: (1 to: 100).
	self assert: ocol size equals: 100.

	ocol at: 2 put: 20.
	self assert: requestCount equals: 1.
	self assert: eventCount equals: 1.
	self assert: reqInterval equals: (2 to: 2).
	self assert: eventInterval equals: (2 to: 2).
	validate := false.
	reqInterval := nil.
	eventInterval := nil.
	ocol at: 2 put: 30.
	self assert: requestCount equals: 2.
	self assert: eventCount equals: 1.
	self assert: reqInterval equals: (2 to: 2).
	self assert: eventInterval isNil.

	validate := true.
	reqInterval := nil.
	eventInterval := nil.
	ocol replaceFrom: 10 to: 20 with: (10 to: 20).
	self assert: requestCount equals: 3.
	self assert: eventCount equals: 2.
	self assert: reqInterval equals: (10 to: 20).
	self assert: eventInterval equals: (10 to: 20)
]
