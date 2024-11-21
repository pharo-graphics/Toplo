"
A ToItemsQueryRunnerTest is a test class for testing the behavior of ToItemsQueryRunner
"
Class {
	#name : #ToItemsQueryRunnerTest,
	#superclass : #TestCase,
	#instVars : [
		'target',
		'queryRunner'
	],
	#category : #'Toplo-Tests-Core-QueryRunner'
}

{ #category : #running }
ToItemsQueryRunnerTest >> setUp [ 

	super setUp.
	target := ToObservableCollection new.
	queryRunner := ToItemsQueryRunner new.
	queryRunner onInstalledIn: target
]

{ #category : #tests }
ToItemsQueryRunnerTest >> testOnInstalledIn [

	self
		assert: queryRunner delay
		equals: queryRunner defaultDelay.
	self assert: queryRunner items equals: #(  ).
	self assert: queryRunner fetcher notNil.
	self assert: (target eventDispatcher handlers anySatisfy: [ :h |
			 (h isKindOf: BlEventHandler) and: [
				 h eventClass = ToItemsQueryRequestEvent ] ])
]

{ #category : #tests }
ToItemsQueryRunnerTest >> testOnUninstalledIn [

	queryRunner onUninstalledIn: target.
	self assert: queryRunner process isNil.
	self assert: queryRunner items equals: #(  ).
	self assert: queryRunner pattern isNil.
	self assert: queryRunner fetcher isNil.
	self assert: (target eventDispatcher handlers noneSatisfy: [ :h |
			 (h isKindOf: BlEventHandler) and: [
				 h eventClass = ToItemsQueryRequestEvent ] ])
]

{ #category : #tests }
ToItemsQueryRunnerTest >> testSeveralQueryRequestEvent [

	| items |
	target
		addEventHandlerOn: ToItemsQueryResultEvent
		do: [ :event | items := event items ].
	target addAll: #('A' 'B' 'C').
	queryRunner fetcher: [ :theTarget :thePattern | theTarget select: [ :v | v = thePattern ] ].
	target dispatchEvent: (ToItemsQueryRequestEvent new
			 pattern: 'B';
			 yourself).
	(queryRunner delay / 10) wait.
	target dispatchEvent: (ToItemsQueryRequestEvent new
			 pattern: 'C';
			 yourself).
	(queryRunner delay + 1000 milliSeconds) wait.
	self assert: items equals: #( 'C' ) asOrderedCollection 
]

{ #category : #tests }
ToItemsQueryRunnerTest >> testitemsQueryRequestEvent [

	| items |
	target
		addEventHandlerOn: ToItemsQueryResultEvent
		do: [ :event | items := event items ].
	target dispatchEvent: (ToItemsQueryRequestEvent new
			 pattern: 'A';
			 yourself).
	(queryRunner delay + 2000 milliSeconds) wait.
	self assert: items equals: #(  )
]

{ #category : #tests }
ToItemsQueryRunnerTest >> testitemsQueryRequestEventWithNotEmptyTarget [

	| items |
	target
		addEventHandlerOn: ToItemsQueryResultEvent
		do: [ :event | items := event items ].
	target addAll: #('A' 'B' 'C').
	queryRunner fetcher: [ :theTarget :thePattern | theTarget select: [ :v | v = thePattern ] ].
	target dispatchEvent: (ToItemsQueryRequestEvent new
			 pattern: 'B';
			 yourself).
	(queryRunner delay + 1000 milliSeconds) wait.
	self assert: items equals: #( 'B' ) asOrderedCollection 
]
