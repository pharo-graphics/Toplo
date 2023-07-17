Trait {
	#name : #TToElementtWithState,
	#instVars : [
		'currentState'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - state processing' }
TToElementtWithState >> currentState [

	^ currentState
]

{ #category : #'t - state processing' }
TToElementtWithState >> switchToState: aState [

	currentState = aState ifTrue: [ ^ self ].
	currentState := aState.
	self dispatchEvent: (ToElementStateChangedEvent new state: currentState; yourself)
]
