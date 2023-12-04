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
	space root addChild: e.
	e when: ToHoveredLookEvent do: [ :event | receivedEvt := event ].
	(ToTransientState lookEvent: (stateEvt := ToHoveredLookEvent new) ) applyOn: e.
	self assert: receivedEvt identicalTo: stateEvt
	
]

{ #category : 'tests' }
ToTransientStateTest >> testLookEvent [

	| state stateEvt |
	state := ToTransientState new.
	state lookEvent: (stateEvt := ToHoveredLookEvent new).
	self assert: state lookEvent identicalTo: stateEvt
	
]

{ #category : 'tests' }
ToTransientStateTest >> testOnAppliedOn [

	| e stateEvt state |
	e := ToElement new.
	space root addChild: e.
	state := ToTransientStateForTest lookEvent: (stateEvt := ToHoveredLookEvent new).
	state applyOn: e.
	self assert: state applyCount equals: 1
	
]

{ #category : 'tests' }
ToTransientStateTest >> testSourceEvent [

	| state stateEvt sourceEvt |
	state := ToTransientState new.
	sourceEvt := BlMouseEnterEvent new position: 10@10.
	state lookEvent: (stateEvt := ToHoveredLookEvent new sourceEvent: sourceEvt).
	self assert: state sourceEvent identicalTo: sourceEvt
]
