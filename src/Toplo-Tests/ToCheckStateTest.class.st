Class {
	#name : #ToCheckStateTest,
	#superclass : #ToTestCaseWithSpace,
	#category : 'Toplo-Tests-Core-States'
}

{ #category : #running }
ToCheckStateTest >> testApplyOn [

	| e state checkedEvt uncheckedEvt |
	e := ToElement new.
	e addEventHandler: (BlEventHandler
			 on: ToCheckedLookEvent
			 do: [ :event | checkedEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToUncheckedLookEvent
			 do: [ :event | uncheckedEvt := event ]).
	state := ToCheckState new checked: true.
	state applyOn: e.
	self assert: (checkedEvt isKindOf: ToCheckedLookEvent)
]

{ #category : #running }
ToCheckStateTest >> testApplyOnUnchecked [

	| e state checkedEvt uncheckedEvt |
	e := ToElement new.
	e addEventHandler: (BlEventHandler
			 on: ToCheckedLookEvent
			 do: [ :event | checkedEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToUncheckedLookEvent
			 do: [ :event | uncheckedEvt := event ]).
	state := ToCheckState new checked: false.
	state applyOn: e.
	self assert: (uncheckedEvt isKindOf: ToUncheckedLookEvent)
]

{ #category : #running }
ToCheckStateTest >> testApplyOnWhenDisabled [
	" even if an element is disabled, enqueuing an intrinsic state is allowed.
	Disabling state change is controled at the level of the API of the element 
	and not at the level of state management"

	| e state checkedEvt uncheckedEvt |
	e := ToElement new.
	e disable.
	e addEventHandler: (BlEventHandler
			 on: ToCheckedLookEvent
			 do: [ :event | checkedEvt := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToUncheckedLookEvent
			 do: [ :event | uncheckedEvt := event ]).
	state := ToCheckState new checked: true.
	state applyOn: e.
	self assert: (checkedEvt isKindOf: ToCheckedLookEvent).
	state := ToCheckState new checked: false.
	state applyOn: e.
	self assert: (uncheckedEvt isKindOf: ToUncheckedLookEvent)
]

{ #category : #running }
ToCheckStateTest >> testLookEvent [

	| state  |
	state := ToCheckState new checked: true.
	self assert: (state lookEvent isKindOf: ToCheckedLookEvent).
	state := ToCheckState new checked: false.
	self assert: (state lookEvent isKindOf: ToUncheckedLookEvent) 

	
]
