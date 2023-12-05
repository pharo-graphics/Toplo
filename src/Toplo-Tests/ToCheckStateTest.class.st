Class {
	#name : 'ToCheckStateTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-States',
	#package : 'Toplo-Tests',
	#tag : 'Core-States'
}

{ #category : 'running' }
ToCheckStateTest >> setUp [ 

	super setUp.
	space := self newTestingSpace. 

]

{ #category : 'running' }
ToCheckStateTest >> testApplyOn [ 

	| e state checkedEvt uncheckedEvt |
	e := ToElement new.
	e when: ToCheckedLookEvent do: [ :event | checkedEvt := event ].
	e when: ToUncheckedLookEvent do: [ :event | uncheckedEvt := event ].
	state := ToCheckState new checked: true.
	state applyOn: e.
	self assert: (checkedEvt isKindOf: ToCheckedLookEvent)
	
]

{ #category : 'running' }
ToCheckStateTest >> testApplyOnUnchecked [

	| e state checkedEvt uncheckedEvt |
	e := ToElement new.
	e when: ToCheckedLookEvent do: [ :event | checkedEvt := event ].
	e when: ToUncheckedLookEvent do: [ :event | uncheckedEvt := event ].
	state := ToCheckState new checked: false.
	state applyOn: e.
	self assert: (uncheckedEvt isKindOf: ToUncheckedLookEvent)
	
]

{ #category : 'running' }
ToCheckStateTest >> testApplyOnWhenDisabled [

	| e state checkedEvt uncheckedEvt |
	e := ToElement new.
	e disable.
	e when: ToCheckedLookEvent do: [ :event | checkedEvt := event ].
	e when: ToUncheckedLookEvent do: [ :event | uncheckedEvt := event ].
	state := ToCheckState new checked: true.
	state applyOn: e.
	self assert: (checkedEvt isKindOf: ToCheckedLookEvent).
	state := ToCheckState new checked: false.
	state applyOn: e.
	self assert: (uncheckedEvt isKindOf: ToUncheckedLookEvent)

	
]

{ #category : 'running' }
ToCheckStateTest >> testLookEvent [

	| state  |
	state := ToCheckState new checked: true.
	self assert: (state lookEvent isKindOf: ToCheckedLookEvent).
	state := ToCheckState new checked: false.
	self assert: (state lookEvent isKindOf: ToUncheckedLookEvent) 

	
]

{ #category : 'tests' }
ToCheckStateTest >> testRequestEnqueueFromElementInQueue [

	| e state |
	e := ToElement new.
	state := ToCheckStateForTest new checked: true.
	state requestEnqueueFromElement: e inQueue: e skinStateQueue.
	" no, the state is not enqueued since a ToInstallState has not been enqueued before "
	self deny: state canBeEnqueued.
	self assert: e skinStateQueue nextStates isEmpty
]

{ #category : 'tests' }
ToCheckStateTest >> testRequestEnqueueFromElementInQueue2 [

	| e state nextInQueue |
	e := ToElement new.
	space root addChild: e.
	state := ToCheckStateForTest new checked: true.
	e skinStateQueue enqueueInstallStateForElement: e.
	state requestEnqueueFromElement: e inQueue: e skinStateQueue.
	self assert: state canBeEnqueued.
	self assert: e skinStateQueue nextStates size equals: 3.
	" first state is always an Install "
	nextInQueue := e skinStateQueue nextStates nextOrNil.
	self assert: (nextInQueue isKindOf: ToInstallState).
	" next state is the intrinsic state (ToCheckStateForState) "
	nextInQueue := e skinStateQueue nextStates nextOrNil.
	self assert: (nextInQueue isKindOf: ToEnablementState).
	nextInQueue := e skinStateQueue nextStates nextOrNil.
	self assert: (nextInQueue isKindOf: ToCheckStateForTest).
	nextInQueue := e skinStateQueue nextStates nextOrNil.
	self assert: (nextInQueue isNil).
	
]

{ #category : 'tests' }
ToCheckStateTest >> testRequestEnqueueFromElementInQueue3 [

	" even if a ToElement is disabled, enqueuing an intrinsic state is allowed.
	Disabling state change is controled at the level of the API of the element 
	and not at the level of state management"

	| e state nextInQueue |
	e := ToElement new.

	e disable.

	space root addChild: e.
	state := ToCheckStateForTest new checked: true.
	e skinStateQueue enqueueInstallStateForElement: e.
	state requestEnqueueFromElement: e inQueue: e skinStateQueue.
	self assert: state canBeEnqueued.
	self assert: e skinStateQueue nextStates size equals: 3.
	" first state is always an Install "
	nextInQueue := e skinStateQueue nextStates nextOrNil.
	self assert: (nextInQueue isKindOf: ToInstallState).
	" next state is the intrinsic state (ToCheckStateForState) "
	nextInQueue := e skinStateQueue nextStates nextOrNil.
	self assert: (nextInQueue isKindOf: ToEnablementState).
	nextInQueue := e skinStateQueue nextStates nextOrNil.
	self assert: (nextInQueue isKindOf: ToCheckStateForTest).
	self assert: nextInQueue checked.
	nextInQueue := e skinStateQueue nextStates nextOrNil.
	self assert: (nextInQueue isNil).
	
]
