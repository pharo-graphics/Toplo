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

	self currentState ifNotNil: [ :curr | 
		curr next counter: curr counter + 1.
		self switchToState: curr next ]
]

{ #category : #'t - state processing' }
TToWidgetWithState >> switchToStartState [

	self currentState ifNotNil: [ :curr | 
		curr counter: 0.
		curr enterOn: self previousState: nil]
]

{ #category : #'t - private state processing' }
TToWidgetWithState >> switchToState: aState [

	| previous |
	previous := self currentState.
	self announce: (ToBeforeStateChangeAnnouncement new
			 widget: self;
			 state: aState;
			 yourself).
	previous ifNotNil: [ previous exitOn: self nextState: aState ].
	self currentState: aState.
	self announce: (ToAfterStateChangeAnnouncement new
			 widget: self;
			 state: aState;
			 previousState: previous;
			 yourself)
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
