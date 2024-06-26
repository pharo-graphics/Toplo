"
A ToTransientStateTest is a test class for testing the behavior of ToTransientState
"
Class {
	#name : #ToTransientStateTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-States'
}

{ #category : #tests }
ToTransientStateTest >> testApplyOn [

	| e stateEvt receivedEvt |
	e := ToElement new.
	" nooo, a transient state must have a lookevent "
	self should: [ ToTransientState new applyOn: e ] raise: Error.
	e addEventHandler: (BlEventHandler
			 on: ToHoveredSkinEvent
			 do: [ :event | receivedEvt := event ]).
	(ToTransientState lookEvent: (stateEvt := ToHoveredSkinEvent new))
		applyOn: e.
	self assert: receivedEvt identicalTo: stateEvt
]

{ #category : #tests }
ToTransientStateTest >> testCanBeEnqueuedFromElementInQueue [

	| e stateEvt state |
	e := ToElement new.
	state := ToTransientStateForTest lookEvent:
		         (stateEvt := ToHoveredSkinEvent new).
	" no, the state is not enqueued since a ToInstallState has not been enqueued before "
	self deny: (state
			 canBeEnqueuedFromElement: e
			 inQueue: e skinManager skinStateQueue).
	state := ToTransientStateForTest lookEvent:
		         (stateEvt := ToHoveredSkinEvent new).
	e skinManager skinStateQueue enqueueInstallStateForElement: e.
	self assert: (state
			 canBeEnqueuedFromElement: e
			 inQueue: e skinManager skinStateQueue)
]

{ #category : #tests }
ToTransientStateTest >> testLookEvent [

	| state stateEvt |
	state := ToTransientState new.
	self assert: state lookEvent isNil.
	state lookEvent: (stateEvt := ToHoveredSkinEvent new).
	self assert: state lookEvent identicalTo: stateEvt
	
]

{ #category : #tests }
ToTransientStateTest >> testOnAppliedOn [

	| e stateEvt state |
	e := ToElement new.
	space root addChild: e.
	state := ToTransientStateForTest lookEvent: (stateEvt := ToHoveredSkinEvent new).
	state applyOn: e.
	self assert: state applyCount equals: 1
	
]

{ #category : #tests }
ToTransientStateTest >> testRequestEnqueueFromElementInQueue [

	| e stateEvt state |
	e := ToElement new.
	state := ToTransientStateForTest lookEvent:
		         (stateEvt := ToHoveredSkinEvent new).
	state
		requestEnqueueFromElement: e
		inQueue: e skinManager skinStateQueue.
	" no, the state is not enqueued since a ToInstallState has not been enqueued before "
	self deny: state canBeEnqueued.
	self assert: e skinManager skinStateQueue nextStates isEmpty.
	state := ToTransientStateForTest lookEvent:
		         (stateEvt := ToHoveredSkinEvent new).
	e skinManager skinStateQueue enqueueInstallStateForElement: e.
	state
		requestEnqueueFromElement: e
		inQueue: e skinManager skinStateQueue.
	self assert: state canBeEnqueued.
	self assert: e skinManager skinStateQueue nextStates size equals: 3.
	self assert:
		(e skinManager skinStateQueue nextStates nextOrNil isKindOf:
			 ToInstallState).
	self assert:
		(e skinManager skinStateQueue nextStates nextOrNil isKindOf:
			 ToEnablementState).
	self assert:
		(e skinManager skinStateQueue nextStates nextOrNil isKindOf:
			 ToTransientState)
]

{ #category : #tests }
ToTransientStateTest >> testSourceEvent [

	| state stateEvt sourceEvt |
	state := ToTransientState new.
	sourceEvt := BlMouseEnterEvent new position: 10@10.
	state lookEvent: (stateEvt := ToHoveredSkinEvent new sourceEvent: sourceEvt).
	self assert: state sourceEvent identicalTo: sourceEvt
]
