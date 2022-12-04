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

	self currentState ifNotNil: [ :curr | self switchToState: curr next ]
]

{ #category : #'t - state processing' }
TToWidgetWithState >> switchToStartState [

	self currentState ifNotNil: [ :curr | self switchToState: curr ]
]

{ #category : #'t - state change hook' }
TToWidgetWithState >> switchToState: aState [

	| previous |
	previous := self currentState.
	self announce: (ToBeforeStateChangeAnnouncement new
			 widget: self;
			 yourself).
	previous ifNotNil: [ previous exitOn: self nextState: aState ].
	self currentState: aState.
	self announce: (ToAfterStateChangeAnnouncement new
			 widget: self;
			 previousState: previous;
			 yourself)
]

{ #category : #'t - state change hook' }
TToWidgetWithState >> switchToStateNamed: aStateName [

	| found |
	found := self stateNamed: aStateName.
	found ifNil: [ ^ self ].
	self switchToState: found
]
