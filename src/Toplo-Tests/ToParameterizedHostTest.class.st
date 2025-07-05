Class {
	#name : #ToParameterizedHostTest,
	#superclass : #BlParameterizedHostTest,
	#instVars : [
		'space'
	],
	#category : #'Toplo-Tests-Core'
}

{ #category : #tests }
ToParameterizedHostTest >> applyAllEnqueuedStates [

	testingSpaces ifNil: [ ^ self ].
	testingSpaces do: [ :each | 
		each applyAllSkinInstallers.
		each applyAllEnqueuedStates. 
		each requestNextPulse ].
]

{ #category : #running }
ToParameterizedHostTest >> setUp [ 

	super setUp.
	space := self newTestingSpace. 

]

{ #category : #tests }
ToParameterizedHostTest >> testingSpace: aSpace showThenDo: aBlock [

	aSpace show.
	BlSpace
		pulseUntilSpaceOpenedAndEmptyTaskQueue: aSpace
		timeout: 200 milliSeconds.
	aBlock value.
	aSpace close
]

{ #category : #tests }
ToParameterizedHostTest >> waitTestingSpaces [

	self waitTestingSpacesTimeout: 200 milliSeconds
]

{ #category : #tests }
ToParameterizedHostTest >> waitTestingSpacesTimeout: aDuration [

	testingSpaces do: [ :each |
		BlSpace pulseUntilEmptyTaskQueue: each timeout: aDuration ]
]
