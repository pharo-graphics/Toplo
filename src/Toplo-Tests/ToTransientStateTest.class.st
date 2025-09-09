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
	" nooo, a transient state must have a SkinEvent "
	self should: [ ToTransientState new applyOn: e ] raise: Error.
	e addEventHandler: (BlEventHandler
			 on: ToHoveredSkinEvent
			 do: [ :event | receivedEvt := event ]).
	(ToTransientState skinEvent: (stateEvt := ToHoveredSkinEvent new))
		applyOn: e fromQueue: nil.
	self assert: receivedEvt identicalTo: stateEvt
]

{ #category : #tests }
ToTransientStateTest >> testOnAppliedOn [

	| e stateEvt state |
	e := ToElement new.
	space root addChild: e.
	state := ToTransientStateStub skinEvent: (stateEvt := ToHoveredSkinEvent new).
	state applyOn: e fromQueue: nil.
	self assert: state applyCount equals: 1
	
]

{ #category : #tests }
ToTransientStateTest >> testSkinEvent [

	| state stateEvt |
	state := ToTransientState new.
	self assert: state skinEvent isNil.
	state skinEvent: (stateEvt := ToHoveredSkinEvent new).
	self assert: state skinEvent identicalTo: stateEvt
	
]

{ #category : #tests }
ToTransientStateTest >> testSourceEvent [

	| state stateEvt sourceEvt |
	state := ToTransientState new.
	sourceEvt := BlMouseEnterEvent new position: 10@10.
	state skinEvent: (stateEvt := ToHoveredSkinEvent new sourceEvent: sourceEvt).
	self assert: state sourceEvent class identicalTo: sourceEvt class
]
