Trait {
	#name : #TToElementWithState,
	#instVars : [
		'#currentState => ObservableSlot'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - state processing' }
TToElementWithState >> currentState [

	^ currentState
]

{ #category : #'t - state processing' }
TToElementWithState >> currentState: aState [

	currentState := aState
]

{ #category : #initialization }
TToElementWithState >> initialize [

	self class initializeSlots: self.
	super initialize.
]

{ #category : #'t - state processing' }
TToElementWithState >> switchToState: aState [

	"self currentState class = aState class ifTrue: [ ^ self ]."
	self currentState: aState.
	self dispatchLookEvent: (ToElementStateChangedEvent new state: aState; yourself)
]

{ #category : #enumerating }
TToElementWithState >> whenCurrentStateChangedDo: aBlock [

	"set a block to perform after that the slot has been changed, and its action performed"

	self property: #currentState whenChangedDo: aBlock
]
