Class {
	#name : 'ToParameterizedHostTest',
	#superclass : 'BlParameterizedHostTest',
	#category : 'Toplo-Tests-Core',
	#package : 'Toplo-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
ToParameterizedHostTest >> applyAllEnqueuedStates [

	testingSpaces ifNil: [ ^ self ].
	testingSpaces do: [ :each | 
		each applyAllSkinInstallers.
		each applyAllEnqueuedStates. 
		each requestNextPulse ].
]

{ #category : 'tests' }
ToParameterizedHostTest >> testingSpace: aSpace showThenDo: aBlock [

	aSpace show.
	aSpace when: BlSpaceShownEvent doOnce: [ :event |
		BlSpace pulseUntilEmptyTaskQueue: aSpace timeout: 200 milliSeconds.
		aBlock cull: event.
		aSpace close ].
	
]

{ #category : 'tests' }
ToParameterizedHostTest >> waitTestingSpaces [

	testingSpaces ifNil: [ ^ self ].
	testingSpaces do: [ :each |
		each requestNextPulse ].
	super waitTestingSpaces
]
