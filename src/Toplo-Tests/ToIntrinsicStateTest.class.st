Class {
	#name : #ToIntrinsicStateTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-States'
}

{ #category : #running }
ToIntrinsicStateTest >> testApplyEnablementOn [

	| e receivedEnabledEvt receivedDisabledEvt |
	e := ToElement new.
	e addEventHandler: (BlEventHandler
			 on: ToEnabledSkinEvent
			 do: [ :event | receivedEnabledEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToDisabledSkinEvent
			 do: [ :event | receivedDisabledEvt := event ]).
	space root addChild: e.
	e skinManager installNewSkinIn: e.
	self assert: (receivedEnabledEvt isKindOf: ToEnabledSkinEvent)
]

{ #category : #running }
ToIntrinsicStateTest >> testApplyEnablementOn2 [

	| e receivedEnabledEvt receivedDisabledEvt |
	e := ToElement new.
	e enable.
	e addEventHandler: (BlEventHandler
			 on: ToEnabledSkinEvent
			 do: [ :event | receivedEnabledEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToDisabledSkinEvent
			 do: [ :event | receivedDisabledEvt := event ]).
	space root addChild: e.
	e skinManager installNewSkinIn: e.
	self assert: (receivedEnabledEvt isKindOf: ToEnabledSkinEvent)
]

{ #category : #running }
ToIntrinsicStateTest >> testApplyEnablementOn3 [

	| e receivedEnabledEvt receivedDisabledEvt |
	e := ToElement new.
	e enable.
	e addEventHandler: (BlEventHandler
			 on: ToEnabledSkinEvent
			 do: [ :event | receivedEnabledEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToDisabledSkinEvent
			 do: [ :event | receivedDisabledEvt := event ]).
	space root addChild: e.
	e skinManager installNewSkinIn: e.
	self assert: (receivedEnabledEvt isKindOf: ToEnabledSkinEvent)
]

{ #category : #running }
ToIntrinsicStateTest >> testApplyEnablementOnWhenDisabled [

	| e receivedEnabledEvt receivedDisabledEvt |
	e := ToElement new.
	e disable.
	e addEventHandler: (BlEventHandler
			 on: ToEnabledSkinEvent
			 do: [ :event | receivedEnabledEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToDisabledSkinEvent
			 do: [ :event | receivedDisabledEvt := event ]).
	space root addChild: e.
	e skinManager installNewSkinIn: e.
	self assert: (receivedDisabledEvt isKindOf: ToDisabledSkinEvent)
]

{ #category : #running }
ToIntrinsicStateTest >> testApplyEnablementOnWhenDisabled2 [

	| e receivedEnabledEvt receivedDisabledEvt |
	e := ToElement new.
	e disable.
	e addEventHandler: (BlEventHandler
			 on: ToEnabledSkinEvent
			 do: [ :event | receivedEnabledEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToDisabledSkinEvent
			 do: [ :event | receivedDisabledEvt := event ]).
	space root addChild: e.
	self assert: (receivedDisabledEvt isKindOf: ToDisabledSkinEvent)
]

{ #category : #running }
ToIntrinsicStateTest >> testApplyOn [ 

	| e state  |
	e := ToElement new.
	state := ToIntrinsicState new.
	state applyOn: e fromQueue: nil
]

{ #category : #running }
ToIntrinsicStateTest >> testApplyOnChecked [

	| e state checkedEvt uncheckedEvt |
	e := ToElement new.
	space root addChild: e.
	e addEventHandler: (BlEventHandler
			 on: ToCheckedSkinEvent
			 do: [ :event | checkedEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToUncheckedSkinEvent
			 do: [ :event | uncheckedEvt := event ]).
	state := ToIntrinsicState new checkedSkinEvent: ToCheckedSkinEvent new.
	state applyOn: e fromQueue: nil.
	self assert: (checkedEvt isKindOf: ToCheckedSkinEvent)
]

{ #category : #running }
ToIntrinsicStateTest >> testApplyOnCheckedWhenDisabled [
	" even if an element is disabled, enqueuing an intrinsic state is allowed.
	Disabling state change is controled at the level of the API of the element 
	and not at the level of state management"

	| e state checkedEvt uncheckedEvt |
	e := ToElement new.
	space root addChild: e.
	e disable.
	e addEventHandler: (BlEventHandler
			 on: ToCheckedSkinEvent
			 do: [ :event | checkedEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToUncheckedSkinEvent
			 do: [ :event | uncheckedEvt := event ]).
	state := ToIntrinsicState new checkedSkinEvent: ToCheckedSkinEvent new.
	state applyOn: e fromQueue: nil.
	self assert: (checkedEvt isKindOf: ToCheckedSkinEvent).
	state := ToIntrinsicState new checkedSkinEvent: ToUncheckedSkinEvent new.
	state applyOn: e fromQueue: nil.
	self assert: (uncheckedEvt isKindOf: ToUncheckedSkinEvent)
]

{ #category : #running }
ToIntrinsicStateTest >> testApplyOnFocused [

	| e state focusedEvt unfocusedEvt |
	e := ToElement new.
	space root addChild: e.
	e addEventHandler: (BlEventHandler
			 on: ToFocusedSkinEvent
			 do: [ :event | focusedEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToUnfocusedSkinEvent
			 do: [ :event | unfocusedEvt := event ]).
	state := ToIntrinsicState new focusedSkinEvent: ToFocusedSkinEvent new.
	state applyOn: e fromQueue: nil.
	self assert: (focusedEvt isKindOf: ToFocusedSkinEvent).
	self assert: unfocusedEvt isNil
]

{ #category : #running }
ToIntrinsicStateTest >> testApplyOnFocusedWhenDisabled [
	" even if an element is disabled, enqueuing an intrinsic state is allowed.
	Disabling state change is controled at the level of the API of the element 
	and not at the level of state management"

	| e state focusedEvt unfocusedEvt |
	e := ToElement new.
	space root addChild: e.
	e disable.
	e addEventHandler: (BlEventHandler
			 on: ToFocusedSkinEvent
			 do: [ :event | focusedEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToUnfocusedSkinEvent
			 do: [ :event | unfocusedEvt := event ]).
	state := ToIntrinsicState new focusedSkinEvent: ToFocusedSkinEvent new.
	state applyOn: e fromQueue: nil.
	self assert: (focusedEvt isKindOf: ToFocusedSkinEvent).
	state := ToIntrinsicState new focusedSkinEvent: ToUnfocusedSkinEvent new.
	state applyOn: e fromQueue: nil.
	self assert: (unfocusedEvt isKindOf: ToUnfocusedSkinEvent)
]

{ #category : #running }
ToIntrinsicStateTest >> testApplyOnUnchecked [

	| e state checkedEvt uncheckedEvt |
	e := ToElement new.
	space root addChild: e.
	e addEventHandler: (BlEventHandler
			 on: ToCheckedSkinEvent
			 do: [ :event | checkedEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToUncheckedSkinEvent
			 do: [ :event | uncheckedEvt := event ]).
	state := ToIntrinsicState new checkedSkinEvent: ToUncheckedSkinEvent new.
	state applyOn: e fromQueue: nil.
	self assert: (uncheckedEvt isKindOf: ToUncheckedSkinEvent)
]

{ #category : #running }
ToIntrinsicStateTest >> testApplyOnUnfocused [

	| e state focusedEvt unfocusedEvt |
	e := ToElement new.
	space root addChild: e.
	e addEventHandler: (BlEventHandler
			 on: ToFocusedSkinEvent
			 do: [ :event | focusedEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToUnfocusedSkinEvent
			 do: [ :event | unfocusedEvt := event ]).
	state := ToIntrinsicState new focusedSkinEvent: ToUnfocusedSkinEvent new.
	state applyOn: e fromQueue: nil.
	self assert: (unfocusedEvt isKindOf: ToUnfocusedSkinEvent).
	self assert: focusedEvt isNil
]
