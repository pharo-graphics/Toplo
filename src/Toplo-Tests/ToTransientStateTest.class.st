"
A ToTransientStateTest is a test class for testing the behavior of ToTransientState
"
Class {
	#name : 'ToTransientStateTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-States',
	#package : 'Toplo-Tests',
	#tag : 'Core-States'
}

{ #category : 'running' }
ToTransientStateTest >> setUp [ 

	super setUp.
	space := self newTestingSpace. 

]

{ #category : 'tests' }
ToTransientStateTest >> testApplyOn [ 

	| e stateEvt receivedEvt |
	e := ToElement new.
	" nooo, a transient state must have a lookevent "
	self should: [ToTransientState new  applyOn: e] raise: Error.
	e when: ToHoveredLookEvent do: [ :event | receivedEvt := event ].
	(ToTransientState lookEvent: (stateEvt := ToHoveredLookEvent new) ) applyOn: e.
	self assert: receivedEvt identicalTo: stateEvt
	
]

{ #category : 'tests' }
ToTransientStateTest >> testCanBeEnqueuedFromElementInQueue [

	| e stateEvt state |
	e := ToElement new.
	state := ToTransientStateForTest lookEvent: (stateEvt := ToHoveredLookEvent new).
	" no, the state is not enqueued since a ToInstallState has not been enqueued before "
	self deny: (state canBeEnqueuedFromElement: e inQueue: e skinStateQueue).
	state := ToTransientStateForTest lookEvent: (stateEvt := ToHoveredLookEvent new).
	e skinStateQueue enqueueInstallStateForElement: e.
	self assert: (state canBeEnqueuedFromElement: e inQueue: e skinStateQueue)
]

{ #category : 'tests' }
ToTransientStateTest >> testLookEvent [

	| state stateEvt |
	state := ToTransientState new.
	self assert: state lookEvent isNil.
	state lookEvent: (stateEvt := ToHoveredLookEvent new).
	self assert: state lookEvent identicalTo: stateEvt
	
]

{ #category : 'tests' }
ToTransientStateTest >> testOnAppliedOn [

	| e lookEvt state |
	e := ToElement new.
	space root addChild: e.
	state := ToTransientStateForTest lookEvent: (lookEvt := ToHoveredLookEvent new).
	state applyOn: e.
	self assert: state applyCount equals: 1.
	self assert: state lookEvent isNil
	
]

{ #category : 'tests' }
ToTransientStateTest >> testOnAppliedOnEventConsumed [

	| e lookEvt state |
	e := ToElement new.
	space root addChild: e.
	state := ToTransientStateForTest lookEvent: (lookEvt := ToHoveredLookEvent new).
	lookEvt sourceEvent: BlMouseEnterEvent new. 
	self deny: lookEvt sourceEvent isConsumed.
	lookEvt consumed: true.
	state applyOn: e.
	self assert: lookEvt sourceEvent isConsumed.
	self assert: lookEvt isConsumed
	
]

{ #category : 'tests' }
ToTransientStateTest >> testOnAppliedOnEventNotConsumed [

	| e lookEvt state |
	e := ToElement new.
	space root addChild: e.
	state := ToTransientStateForTest lookEvent: (lookEvt := ToHoveredLookEvent new).
	lookEvt sourceEvent: BlMouseEnterEvent new. 
	self deny: lookEvt sourceEvent isConsumed.
	state applyOn: e.
	self deny: lookEvt sourceEvent isConsumed.
	self deny: lookEvt isConsumed
	
]

{ #category : 'tests' }
ToTransientStateTest >> testRequestEnqueueFromElementInQueue [

	| e stateEvt state |
	e := ToElement new.
	state := ToTransientStateForTest lookEvent: (stateEvt := ToHoveredLookEvent new).
	state requestEnqueueFromElement: e inQueue: e skinStateQueue.
	" no, the state is not enqueued since a ToInstallState has not been enqueued before "
	self deny: state canBeEnqueued.
	self assert: e skinStateQueue nextStates isEmpty.
	state := ToTransientStateForTest lookEvent: (stateEvt := ToHoveredLookEvent new).
	e skinStateQueue enqueueInstallStateForElement: e.
	state requestEnqueueFromElement: e inQueue: e skinStateQueue.
	self assert: state canBeEnqueued.
	" 3 states: install, enabled and the transient state "
	self assert: e skinStateQueue nextStates size equals: 3
]

{ #category : 'tests' }
ToTransientStateTest >> testSourceEvent [

	| state stateEvt sourceEvt |
	state := ToTransientState new.
	sourceEvt := BlMouseEnterEvent new position: 10@10.
	state lookEvent: (stateEvt := ToHoveredLookEvent new sourceEvent: sourceEvt).
	self assert: state sourceEvent identicalTo: sourceEvt
]
