Class {
	#name : #ToGeneralButton,
	#superclass : #BlElement,
	#traits : 'TToWidget',
	#classTraits : 'TToWidget classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #'processing - toggle state' }
ToGeneralButton >> applyStartState [

	| curr |
	(curr := self currentState) ifNil: [ ^ self ].
	curr applyStartStateOn: self
]

{ #category : #'processing - toggle state' }
ToGeneralButton >> applyStateTransition [

	| curr |
	(curr := self currentState) ifNil: [ ^ self ].
	curr applyStateTransitionOn: self.
	self currentState: curr next
]

{ #category : #'mouse handlers' }
ToGeneralButton >> clickEvent: anEvent [


]

{ #category : #accessing }
ToGeneralButton >> currentState [

	^ self userData at: #currentState ifAbsent: [  ]
]

{ #category : #accessing }
ToGeneralButton >> currentState: aState [

	| prev |
	prev := self currentState.
	self userData at: #currentState put: aState.
	self stateChangeAction ifNotNil: [ :action | 
		action cull: aState cull: prev ]
]

{ #category : #'t - initialization' }
ToGeneralButton >> defaultDresser [

	^ ToButtonDefaultDresser new
]

{ #category : #initialization }
ToGeneralButton >> defaultViewModel [ 

	^ ToGeneralButtonModel new
]

{ #category : #initialization }
ToGeneralButton >> initialize [ 

	self class initializeSlots: self.
	super initialize.
	self whenClickedDo: [ self applyStateTransition ].
	
	self dresser: self defaultDresser 
]

{ #category : #'accessing - toggle state' }
ToGeneralButton >> stateChangeAction [

	^ self userData at: #stateChangeAction ifAbsent: [  ]
]

{ #category : #'accessing - toggle state' }
ToGeneralButton >> stateChangeAction: aBlock [

	^ self userData at: #stateChangeAction put: aBlock
]

{ #category : #'accessing - toggle state' }
ToGeneralButton >> stateNamed: anObject [

	| curr |
	(curr := self currentState) ifNil: [ ^ nil ].
	[ 
	curr name = anObject ifTrue: [ ^ curr ].
	curr := curr next.
	curr = self currentState ] whileFalse: [  ]
]

{ #category : #'accessing - toggle state' }
ToGeneralButton >> states: aCollectionOfStates [

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
	self applyStartState
]

{ #category : #'api - change hook' }
ToGeneralButton >> switchToStateNamed: aStateName [

	| found curr |
	found := self stateNamed: aStateName.
	found ifNil: [ ^ self ].
	found = (curr := self currentState) ifTrue: [ ^ self ].
	curr exitOn: self nextState: found.
	self currentState: found
]

{ #category : #'api-  action' }
ToGeneralButton >> whenClickedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self whenAnnouncement: ToButtonClickLaunchAction do: aBlock
]

{ #category : #'api - change hook' }
ToGeneralButton >> whenCurrentStateChangedDo: aBlock [
	"Inform when the current state has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new state
	 - old state"

	self stateChangeAction: aBlock
]
