Class {
	#name : #ToParameterizedHostTest,
	#superclass : #BlParameterizedHostTest,
	#category : 'Toplo-Tests-Core'
}

{ #category : #tests }
ToParameterizedHostTest >> waitTestingSpaces [

	testingSpaces do: [ :each | each requestNextPulse ].
	super waitTestingSpaces
]
