Class {
	#name : #ToSandBoxMockTest,
	#superclass : #TestCase,
	#category : #'Toplo-Examples-SandBox'
}

{ #category : #tests }
ToSandBoxMockTest >> closeWindows [

		BlOSWindowSDL2Host universe closeSpaces.
	BlOSWindowSDL2Host
		stop;
		start.
	BlMorphicWindowHost universe closeSpaces.
	BlMorphicWindowHost
		stop;
		start.
	BlSpace allInstances do: [ :each | each close ].
	BlParallelUniverse all do: [ :each | each closeSpaces ].
]

{ #category : #tests }
ToSandBoxMockTest >> testMocks [

	| selectors errors sortedSelectors exceptions |
	self skip.
	self timeLimit: 120 seconds.
	errors := OrderedCollection new.
	exceptions := OrderedCollection new.
	selectors := ToSandBox class selectors select: [ :each |
		             each beginsWith: 'example' ].
	sortedSelectors := SortedCollection new.
	sortedSelectors
		sortBlock: [ :a :b | a < b ];
		addAll: selectors.

	"
	#example_SieveOnList2With_350000_Items produces a test time out even if we set 20 Seconds as a limit
	this is suspicious.
	"

	self assert: sortedSelectors isNotEmpty.

	sortedSelectors do: [ :each |
		[
		ToSandBox perform: each.
		Delay forMilliseconds: 5000.
		self closeWindows ]
			on: Error
			do: [ :err |
				errors add: each.
				exceptions add: err ] ].

	self
		assert: errors isEmpty
		description:
		'The following selectors are broken: ' , errors printString
]
