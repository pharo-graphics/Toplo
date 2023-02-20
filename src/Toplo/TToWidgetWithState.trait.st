Trait {
	#name : #TToWidgetWithState,
	#instVars : [
		'currentState',
		'startState'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - state processing' }
TToWidgetWithState >> canSwitchToNextState [ 

	^ self currentState notNil
]

{ #category : #'t - accessing state' }
TToWidgetWithState >> currentState [

	^ currentState
]

{ #category : #'t - accessing state' }
TToWidgetWithState >> currentState: aState [

	currentState := aState
]

{ #category : #'t - accessing state' }
TToWidgetWithState >> setUpStatesWith: aCollectionOfStates [

	| curr states |
	self currentState: nil.
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
TToWidgetWithState >> startState [

	^ startState ifNil: [ self currentState ]
]

{ #category : #'t - accessing state' }
TToWidgetWithState >> startState: aState [

	startState := aState.
	self switchToStartState
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

	self canSwitchToNextState ifFalse: [ ^ self ].
	self currentState in: [:curr | 
		curr next counter: curr counter + 1.
		self switchToState: curr next ] 
]

{ #category : #'t - state processing' }
TToWidgetWithState >> switchToStartState [

	self startState ifNotNil: [ :curr | 
		curr counter: 0.
		curr enterOn: self previousState: nil.
		self currentState: curr]
]

{ #category : #'t - private state processing' }
TToWidgetWithState >> switchToState: aState [

	| previous |
	previous := self currentState.
	" do nothing if aState is the current state whereas several states exist "
	(previous = aState and: [previous next ~= previous]) ifTrue: [ ^ self ].
	self currentState: aState.
	previous ifNotNil: [ previous exitOn: self nextState: aState ].

]

{ #category : #'t - accessing state' }
TToWidgetWithState >> switchToStateNamed: aStateName [

	| found n |
	found := self stateNamed: aStateName.
	found ifNil: [ ^ self ].
	n := self currentState ifNil: [ 0 ] ifNotNil: [ :s | s counter ].
	found counter: n + 1.
	self switchToState: found
]
