Class {
	#name : #ToTopLevelMockTest,
	#superclass : #TestCase,
	#category : #'Toplo-Examples-TopLevel'
}

{ #category : #tests }
ToTopLevelMockTest >> testMocks [

	| errors |
	errors := OrderedCollection new.


	{ ToLoginPage. ToMiniBrowser . ToTextFieldPopupExperiment . ToWorkspaceExample }  do: [ :each |
		[ each  open ]
			on: Error
			do: [ :err | errors add: each ] ].

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
		'The following examples are broken: ' , errors printString
]
