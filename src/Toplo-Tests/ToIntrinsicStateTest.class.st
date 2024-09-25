Class {
	#name : #ToIntrinsicStateTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-States'
}

{ #category : #running }
ToIntrinsicStateTest >> testApplyOn [ 

	| e state  |
	e := ToElement new.
	state := ToIntrinsicStateStub new.
	state applyOn: e
]

{ #category : #tests }
ToIntrinsicStateTest >> testApplyOnEnqueueFromElementInQueue [

	| e firstValState secondValState |
	e := ToElement new.
	firstValState := ToIntrinsicStateStub new val: #firstVal.
	firstValState
		requestEnqueueFromElement: e
		inQueue: e skinManager skinStateQueue.
	" no, the state is not enqueued since a ToInstallState has not been enqueued before "
	self deny: firstValState canBeEnqueued.
	self assert: e skinManager skinStateQueue nextStates isEmpty.
	secondValState := ToIntrinsicStateStub new val: #secondVal.
	e skinManager skinStateQueue enqueueInstallStateForElement: e.
	secondValState
		requestEnqueueFromElement: e
		inQueue: e skinManager skinStateQueue.
	self assert: secondValState canBeEnqueued.
	e skinManager skinStateQueue applyEnqueuedStatesIn: e.

	self assert: firstValState applyCount equals: 1.
	self assert: secondValState applyCount equals: 1.
	self assert: e skinManager skinStateQueue nextStates isEmpty
]

{ #category : #running }
ToIntrinsicStateTest >> testApplyOnUnchecked [

	| e state checkedEvt uncheckedEvt |
	e := ToElement new.
	e addEventHandler: (BlEventHandler
			 on: ToCheckedSkinEvent
			 do: [ :event | checkedEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToUncheckedSkinEvent
			 do: [ :event | uncheckedEvt := event ]).
	state := ToCheckState new checked: false.
	state applyOn: e.
	self assert: (uncheckedEvt isKindOf: ToUncheckedSkinEvent)
]

{ #category : #running }
ToIntrinsicStateTest >> testApplyOnWhenDisabled [
	" even if an element is disabled, enqueuing an intrinsic state is allowed.
	Disabling state change is controled at the level of the API of the element 
	and not at the level of state management"

	| e state checkedEvt uncheckedEvt |
	e := ToElement new.
	e disable.
	e addEventHandler: (BlEventHandler
			 on: ToCheckedSkinEvent
			 do: [ :event | checkedEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToUncheckedSkinEvent
			 do: [ :event | uncheckedEvt := event ]).
	state := ToCheckState new checked: true.
	state applyOn: e.
	self assert: (checkedEvt isKindOf: ToCheckedSkinEvent).
	state := ToCheckState new checked: false.
	state applyOn: e.
	self assert: (uncheckedEvt isKindOf: ToUncheckedSkinEvent)
]

{ #category : #tests }
ToIntrinsicStateTest >> testRequestEnqueueFromElementInQueue [

	| e state nextInQueue firstValState secondValState |
	e := ToElement new.
	state := ToIntrinsicStateStub new val: #firstVal.
	state
		requestEnqueueFromElement: e
		inQueue: e skinManager skinStateQueue.
	" no, the state is not enqueued since a ToInstallState has not been enqueued before "
	self deny: state canBeEnqueued.
	self assert: e skinManager skinStateQueue nextStates isEmpty.
	state := ToIntrinsicStateStub new val: #secondVal.
	e skinManager skinStateQueue enqueueInstallStateForElement: e.
	state
		requestEnqueueFromElement: e
		inQueue: e skinManager skinStateQueue.
	self assert: state canBeEnqueued.
	nextInQueue := e skinManager skinStateQueue nextStates first.
	self assert: (nextInQueue isKindOf: ToInstallState).
	nextInQueue := e skinManager skinStateQueue nextStates second.
	self assert: (nextInQueue isKindOf: ToEnablementState).
	nextInQueue := e skinManager skinStateQueue nextStates third.
	self assert: (nextInQueue isKindOf: ToIntrinsicStateStub).
	" the previously enqueued state was for #firstVal "
	firstValState := nextInQueue.
	self assert: nextInQueue val equals: #firstVal.
	nextInQueue := e skinManager skinStateQueue nextStates fourth.
	self assert: (nextInQueue isKindOf: ToIntrinsicStateStub).
	" the last enqueued state is for #secondVal "
	secondValState := nextInQueue.
	self assert: nextInQueue val equals: #secondVal.
	self assert: e skinManager skinStateQueue nextStates size = 4
]

{ #category : #running }
ToIntrinsicStateTest >> testSkinEvent [

	| state  |
	state := ToCheckState new checked: true.
	self assert: (state skinEvent isKindOf: ToCheckedSkinEvent).
	state := ToCheckState new checked: false.
	self assert: (state skinEvent isKindOf: ToUncheckedSkinEvent) 

	
]
