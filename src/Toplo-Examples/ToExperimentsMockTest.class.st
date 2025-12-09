Class {
	#name : #ToExperimentsMockTest,
	#superclass : #TestCase,
	#category : #'Toplo-Examples-Experiments'
}

{ #category : #tests }
ToExperimentsMockTest >> closeWindows [

	{
		BlOSWindowSDL2Host.
		BlMorphicWindowHost } do: [ :host |
			host universe closeSpaces.
			host
				stop;
				start ].
	BlSpace allInstances do: [ :each | each close ].
	BlParallelUniverse all do: [ :each | each closeSpaces ]
]

{ #category : #tests }
ToExperimentsMockTest >> testMocks [

	| selectors errors |

	self skip.
	errors := OrderedCollection new.
	selectors := ToExperiments class selectors select: [ :each |
		             each beginsWith: 'example' ].
	self assert: selectors isNotEmpty.

	selectors do: [ :each |
		[ ToExperiments perform: each.
		Delay forMilliseconds: 5000.
		self closeWindows ]
			on: Error
			do: [ :err | errors add: each ] ].

	self
		assert: errors isEmpty
		description:
		'The following selectors are broken: ' , errors printString
]
