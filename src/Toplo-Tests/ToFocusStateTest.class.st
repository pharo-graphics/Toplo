Class {
	#name : #ToFocusStateTest,
	#superclass : #ToTestCaseWithSpace,
	#category : 'Toplo-Tests-Core-States'
}

{ #category : #running }
ToFocusStateTest >> testApplyOn [

	| e state focusedEvt unfocusedEvt |
	e := ToElement new.
	e addEventHandler: (BlEventHandler
			 on: ToFocusedLookEvent
			 do: [ :event | focusedEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToUnfocusedLookEvent
			 do: [ :event | unfocusedEvt := event ]).
	state := ToFocusState new focused: true.
	state applyOn: e.
	self assert: (focusedEvt isKindOf: ToFocusedLookEvent).
	self assert: unfocusedEvt isNil
]

{ #category : #running }
ToFocusStateTest >> testApplyOnUnfocused [

	| e state focusedEvt unfocusedEvt |
	e := ToElement new.
	e addEventHandler: (BlEventHandler
			 on: ToFocusedLookEvent
			 do: [ :event | focusedEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToUnfocusedLookEvent
			 do: [ :event | unfocusedEvt := event ]).
	state := ToFocusState new focused: false.
	state applyOn: e.
	self assert: (unfocusedEvt isKindOf: ToUnfocusedLookEvent).
	self assert: focusedEvt isNil
]

{ #category : #running }
ToFocusStateTest >> testApplyOnWhenDisabled [
	" even if an element is disabled, enqueuing an intrinsic state is allowed.
	Disabling state change is controled at the level of the API of the element 
	and not at the level of state management"

	| e state focusedEvt unfocusedEvt |
	e := ToElement new.
	e disable.
	e addEventHandler: (BlEventHandler
			 on: ToFocusedLookEvent
			 do: [ :event | focusedEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToUnfocusedLookEvent
			 do: [ :event | unfocusedEvt := event ]).
	state := ToFocusState new focused: true.
	state applyOn: e.
	self assert: (focusedEvt isKindOf: ToFocusedLookEvent).
	state := ToFocusState new focused: false.
	state applyOn: e.
	self assert: (unfocusedEvt isKindOf: ToUnfocusedLookEvent)
]

{ #category : #running }
ToFocusStateTest >> testLookEvent [

	| state  |
	state := ToFocusState new focused: true.
	self assert: (state lookEvent isKindOf: ToFocusedLookEvent).
	state := ToFocusState new focused: false.
	self assert: (state lookEvent isKindOf: ToUnfocusedLookEvent ) 

	
]
