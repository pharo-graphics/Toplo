Trait {
	#name : #TToWidgetWithState,
	#category : #'Toplo-Core'
}

{ #category : #'t - accessing state' }
TToWidgetWithState >> currentState [

	^ self userData at: #currentState ifAbsent: [  ]
]

{ #category : #'t - accessing state' }
TToWidgetWithState >> currentState: aState [

	self userData at: #currentState put: aState
]

{ #category : #'t - accessing state' }
TToWidgetWithState >> setUpStatesWith: aCollectionOfStates [

	| curr states |
	self userData removeKey: #currentState ifAbsent: [].
	aCollectionOfStates ifEmpty: [ ^self ].
	states := aCollectionOfStates copy asOrderedCollection.
	self currentState: states removeFirst. 
	curr := self currentState.
	[ states isEmpty ] whileFalse: [ 
		curr next: states removeFirst.
		curr := curr next ].
	curr next: self currentState.
	self switchToStartState
]

{ #category : #'t - accessing state' }
TToWidgetWithState >> stateChangeAction [

	^ self userData at: #stateChangeAction ifAbsent: [  ]
]

{ #category : #'t - accessing state' }
TToWidgetWithState >> stateChangeAction: aBlock [

	^ self userData at: #stateChangeAction put: aBlock
]

{ #category : #'t - accessing state' }
TToWidgetWithState >> stateNamed: anObject [

	| curr |
	(curr := self currentState) ifNil: [ ^ nil ].
	[ 
	curr name = anObject ifTrue: [ ^ curr ].
	curr := curr next.
	curr = self currentState ] whileFalse: [  ]
]

{ #category : #'t - state processing' }
TToWidgetWithState >> switchToNextState [

	self currentState ifNotNil: [ :curr | self switchToState: curr next ]
]

{ #category : #'t - state processing' }
TToWidgetWithState >> switchToStartState [

	self currentState ifNotNil: [ :curr | self switchToState: curr ]
]

{ #category : #'t - state change hook' }
TToWidgetWithState >> switchToState: aState [

	|  previous |
	previous := self currentState.
	previous ifNotNil: [ previous exitOn: self nextState: aState].
	self currentState: aState.
	self stateChangeAction ifNotNil: [ :action | action cull: aState cull: previous ]
]

{ #category : #'t - state change hook' }
TToWidgetWithState >> switchToStateNamed: aStateName [

	| found |
	found := self stateNamed: aStateName.
	found ifNil: [ ^ self ].
	self switchToState: found
]

{ #category : #'t - state change hook' }
TToWidgetWithState >> whenCurrentStateChangedDo: aBlock [
	"Inform when the current state has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new state
	 - old state"

	self stateChangeAction: aBlock
]
