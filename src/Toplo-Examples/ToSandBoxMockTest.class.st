Class {
	#name : #ToSandBoxMockTest,
	#superclass : #TestCase,
	#category : #'Toplo-Examples-SandBox'
}

{ #category : #tests }
ToSandBoxMockTest >> testMocks [

	| selectors errors sortedSelectors exceptions |
	self timeLimit: 10 seconds.
	errors := OrderedCollection new.
	exceptions := OrderedCollection new.
	selectors := ToSandBox class selectors select: [ :each |
		             each beginsWith: 'example' ].
	sortedSelectors := SortedCollection new.
	sortedSelectors
		sortBlock: [ :a :b | a < b ];
		addAll: selectors.

	self assert: sortedSelectors isNotEmpty.

	sortedSelectors do: [ :each |
		[ ToSandBox perform: each ]
			on: Error
			do: [ :err |
				errors add: each.
				exceptions add: err ] ].

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


	self
		assert: errors isEmpty
		description:
		'The following selectors are broken: ' , errors printString
]
