Class {
	#name : 'ToParameterizedHostTest',
	#superclass : 'BlParameterizedHostTest',
	#category : 'Toplo-Tests-Core',
	#package : 'Toplo-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
ToParameterizedHostTest >> waitTestingSpaces [

	testingSpaces do: [ :each | each requestNextPulse ].
	super waitTestingSpaces
]
