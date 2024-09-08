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
	self timeLimit: 120 seconds.
	errors := OrderedCollection new.
	exceptions := OrderedCollection new.
	selectors := ToSandBox class selectors select: [ :each |
		             each beginsWith: 'example' ].
	sortedSelectors := SortedCollection new.
	sortedSelectors
		sortBlock: [ :a :b | a < b ];
		addAll: selectors.

	"waiting for the issues to be addressed 
		https://github.com/pharo-graphics/Toplo/issues/195
		https://github.com/pharo-graphics/Toplo/issues/194
	we remove the following selectors for the execution
	
	#example_SieveOnList2With_350000_Items produces a test time out even if we set 20 Seconds as a limit
	this is suspicious.
	"

	sortedSelectors := sortedSelectors reject: [ :each |
		                   #( #example_toButtonWithIconAndTextAndExtra
		                      example_toButtonWithTextAndIconHorizontal
		                      example_toButtonWithTextAndIconHorizontal2
		                      example_toButtonWithTextAndIconHorizontal3
		                      #example_SieveOnList2With_350000_Items )
			                   includes: each ].

	self assert: sortedSelectors isNotEmpty.

	sortedSelectors do: [ :each |
		[ ToSandBox perform: each.
		Delay forMilliseconds: 5000.
		self closeWindows.

		
		 ]
			on: Error
			do: [ :err |
				errors add: each.
				exceptions add: err ] ].

	

	self
		assert: errors isEmpty
		description:
		'The following selectors are broken: ' , errors printString
]
