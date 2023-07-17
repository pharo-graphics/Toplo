Trait {
	#name : #TToElementtWithStateDep,
	#instVars : [
		'currentState',
		'startState'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - state processing' }
TToElementtWithStateDep >> canSwitchToNextState [ 

	^ self currentState notNil
]

{ #category : #'t - accessing state' }
TToElementtWithStateDep >> currentState [

	^ currentState
]

{ #category : #'t - private state processing' }
TToElementtWithStateDep >> currentState: aState [

	currentState := aState
]

{ #category : #'t - accessing state' }
TToElementtWithStateDep >> setUpStatesWith: aCollectionOfStates [
	| curr states previousState |
	
	previousState := self currentState.

	self widgetStatesDo: [ :s | s onUninstalledIn: self ].

	self currentState: nil.
	aCollectionOfStates ifEmpty: [ ^self ].
	states := aCollectionOfStates copy asOrderedCollection.
	self currentState: states removeFirst. 
	curr := self currentState.
	[ states isEmpty ] whileFalse: [ 
		curr next: states removeFirst.
		curr := curr next ].
	curr next: self currentState.

	self widgetStatesDo: [ :s | s onInstalledIn: self ].

	(previousState isNil or:[ (self stateNamed: previousState name) isNil]) 
		ifTrue: [ self switchToStartState ] 
		ifFalse: [ self currentState: (self stateNamed: (previousState name))].
	
	self dispatchEvent: ToStatesSetupEvent new

	
	
]

{ #category : #'t - accessing state' }
TToElementtWithStateDep >> startState [

	^ startState ifNil: [ self currentState ]
]

{ #category : #'t - private state processing' }
TToElementtWithStateDep >> startState: aState [

	startState := aState.
	self switchToStartState
]

{ #category : #'t - accessing state' }
TToElementtWithStateDep >> stateNamed: anObject [

	| curr |
	(curr := self currentState) ifNil: [ ^ nil ].
	[ 
	curr name = anObject ifTrue: [ ^ curr ].
	curr := curr next.
	curr = self currentState ] whileFalse: [  ].
	self error: 'No ', anObject asString, ' state exists.'.

]

{ #category : #'t - state processing' }
TToElementtWithStateDep >> switchToNextState [

	self canSwitchToNextState ifFalse: [ ^ self ].
	self currentState in: [:curr | 
		curr next counter: curr counter + 1.
		self switchToState: curr next ] 
]

{ #category : #'t - state processing' }
TToElementtWithStateDep >> switchToStartState [

	self startState ifNotNil: [ :curr | 
		curr counter: 0.
		curr enterOn: self previousState: nil.
		self currentState: curr]
]

{ #category : #'t - private state processing' }
TToElementtWithStateDep >> switchToState: aState [

	| previous |
	previous := self currentState.
	" do nothing if aState is the current state whereas several states exist "
	(previous = aState and: [previous next ~= previous]) ifTrue: [ ^ self ].
	self currentState: aState.
	previous ifNotNil: [ previous exitOn: self nextState: aState ].

]

{ #category : #'t - accessing state' }
TToElementtWithStateDep >> switchToStateNamed: aStateName [

	| found n |
	found := self stateNamed: aStateName.
	n := self currentState ifNil: [ 0 ] ifNotNil: [ :s | s counter ].
	found counter: n + 1.
	self switchToState: found
]

{ #category : #'t - accessing state' }
TToElementtWithStateDep >> widgetStates [

	^ Array streamContents: [ :stream |
		  self widgetStatesDo: [ :s | stream nextPut: s ] ]
]

{ #category : #'t - accessing state' }
TToElementtWithStateDep >> widgetStatesDo: aBlock [

	| start curr |
	self currentState ifNil: [ ^ self ].
	start := self currentState.
	aBlock value: start.
	curr := start next.
	[ curr = start ] whileFalse: [
		aBlock value: curr.
		curr := curr next ]
]
