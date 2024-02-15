"
A ToCollectionEmptinessEventTest is a test class for testing the behavior of ToCollectionEmptinessEvent
"
Class {
	#name : #ToCollectionEmptinessEventTest,
	#superclass : #TestCase,
	#category : 'Toplo-Tests-Core-Collection'
}

{ #category : #tests }
ToCollectionEmptinessEventTest >> testSendTo [

	| l count |
	l := ToObservableCollection new.
	l add: 5.
	count := 0.
	l addEventHandler: (BlEventHandler
			 on: ToCollectionEmptinessEvent
			 do: [ count := count + 1 ]).
	l removeAt: 1.
	self assert: count equals: 1.
	l add: 5.
	self assert: count equals: 2.
	l removeAll.
	self assert: count equals: 3
]
