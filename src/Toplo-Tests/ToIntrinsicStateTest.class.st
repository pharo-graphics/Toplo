Class {
	#name : 'ToIntrinsicStateTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-States',
	#package : 'Toplo-Tests',
	#tag : 'Core-States'
}

{ #category : 'running' }
ToIntrinsicStateTest >> setUp [ 

	super setUp.
	space := self newTestingSpace. 

]

{ #category : 'running' }
ToIntrinsicStateTest >> testApplyOn [ 

	| e state  |
	e := ToElement new.
	state := ToIntrinsicStateForTest new.
	state applyOn: e
]

{ #category : 'tests' }
ToIntrinsicStateTest >> testApplyOnEnqueueFromElementInQueue [

	| e nextInQueue firstValState secondValState |
	e := ToElement new.
	firstValState := ToIntrinsicStateForTest new val: #firstVal.
	firstValState requestEnqueueFromElement: e inQueue: e skinStateQueue.
	" no, the state is not enqueued since a ToInstallState has not been enqueued before "
	self deny: firstValState canBeEnqueued.
	self assert: e skinStateQueue nextStates isEmpty.
	secondValState := ToIntrinsicStateForTest new val: #secondVal.
	e skinStateQueue enqueueInstallStateForElement: e.
	secondValState requestEnqueueFromElement: e inQueue: e skinStateQueue.
	self assert: secondValState canBeEnqueued.
	e skinStateQueue applyEnqueuedStatesIn: e.

	self assert: firstValState applyCount equals: 1.
	self assert: secondValState applyCount equals: 1.
	nextInQueue := e skinStateQueue nextStates nextOrNil.
	self assert: nextInQueue isNil
]

{ #category : 'running' }
ToIntrinsicStateTest >> testApplyOnUnchecked [

	| e state checkedEvt uncheckedEvt |
	e := ToElement new.
	e when: ToCheckedLookEvent do: [ :event | checkedEvt := event ].
	e when: ToUncheckedLookEvent do: [ :event | uncheckedEvt := event ].
	state := ToCheckState new checked: false.
	state applyOn: e.
	self assert: (uncheckedEvt isKindOf: ToUncheckedLookEvent)
	
]

{ #category : 'running' }
ToIntrinsicStateTest >> testApplyOnWhenDisabled [
	" even if an element is disabled, enqueuing an intrinsic state is allowed.
	Disabling state change is controled at the level of the API of the element 
	and not at the level of state management"

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
ToIntrinsicStateTest >> testLookEvent [

	| state  |
	state := ToCheckState new checked: true.
	self assert: (state lookEvent isKindOf: ToCheckedLookEvent).
	state := ToCheckState new checked: false.
	self assert: (state lookEvent isKindOf: ToUncheckedLookEvent) 

	
]

{ #category : 'tests' }
ToIntrinsicStateTest >> testRequestEnqueueFromElementInQueue [

	| e state nextInQueue firstValState secondValState |
	e := ToElement new.
	state := ToIntrinsicStateForTest new val: #firstVal.
	state requestEnqueueFromElement: e inQueue: e skinStateQueue.
	" no, the state is not enqueued since a ToInstallState has not been enqueued before "
	self deny: state canBeEnqueued.
	self assert: e skinStateQueue nextStates isEmpty.
	state := ToIntrinsicStateForTest new val: #secondVal.
	e skinStateQueue enqueueInstallStateForElement: e.
	state requestEnqueueFromElement: e inQueue: e skinStateQueue.
	self assert: state canBeEnqueued.
	nextInQueue := e skinStateQueue nextStates nextOrNil.
	self assert: (nextInQueue isKindOf: ToInstallState).
	nextInQueue := e skinStateQueue nextStates nextOrNil.
	self assert: (nextInQueue isKindOf: ToIntrinsicStateForTest).
	" the previously enqueued state was for #firstVal "
	firstValState := nextInQueue.
	self assert: nextInQueue val equals: #firstVal.
	nextInQueue := e skinStateQueue nextStates nextOrNil.
	self assert: (nextInQueue isKindOf: ToEnablementState).
	nextInQueue := e skinStateQueue nextStates nextOrNil.
	self assert: (nextInQueue isKindOf: ToIntrinsicStateForTest).
	" the last enqueued state is for #secondVal "
	secondValState := nextInQueue.
	self assert: nextInQueue val equals: #secondVal.
	nextInQueue := e skinStateQueue nextStates nextOrNil.
	self assert: nextInQueue isNil
]
