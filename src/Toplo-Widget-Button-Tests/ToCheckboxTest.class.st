Class {
	#name : #ToCheckboxTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Widget-Button-Tests-Checkable'
}

{ #category : #tests }
ToCheckboxTest >> testCheckUncheckStates [

	| cb |
	cb := ToCheckbox new.
	self assert: cb checked not.
	cb checked: true.
	self assert: cb checked
]

{ #category : #tests }
ToCheckboxTest >> testChecked [

	| cb  |
	cb := ToCheckbox new.
	cb checked: true.
	self assert: cb checked.
	cb disable.
	self assert: cb checked.
	

]

{ #category : #tests }
ToCheckboxTest >> testCheckedDisabledInSpace [

	| chb |
	chb := ToCheckbox new label: (ToLabel text: 'Checkbox').
	chb checked: true.
	self assert: chb icon isNil.
	space root addChild: chb.
	self assert: chb icon notNil.
	space applyAllSkinPhases.
	self assert: chb icon notNil.
	chb disabled: true.

]

{ #category : #tests }
ToCheckboxTest >> testCheckedDisabledInSpace2 [

	| chb |
	chb := ToCheckbox new label: (ToLabel text: 'Checkbox').
	chb checked: true.
	chb disabled: true.
	space root addChild: chb.
	space applyAllSkinPhases.
	self assert: chb icon notNil
]

{ #category : #tests }
ToCheckboxTest >> testCheckedWhenDisabled [

	| cb  checked |
	cb := ToCheckbox new.
	checked := cb isChecked.
	cb checked: checked not.
	self deny: cb isChecked equals: checked.
	cb disable.
	checked := cb isChecked.
	cb checked: checked not.
	self assert: cb isChecked equals: checked.
	

]

{ #category : #tests }
ToCheckboxTest >> testIndeterminateState [

	| cb |
	cb := ToCheckbox new.
	self should: [ cb checked: nil] raise: Error.
	self assert: cb isIndeterminate not.
	self assert: cb isUnchecked 
]

{ #category : #tests }
ToCheckboxTest >> testStartChecked [

	| cb |
	cb := ToCheckbox new.
	cb checked: true.
	space root addChild: cb.
	self assert: cb checked.
	cb addEventHandler: (BlEventHandler
			 on: ToAddedToSpaceEvent 
			 do: [ space close ])
]

{ #category : #tests }
ToCheckboxTest >> testStartCheckedThenDisabled [

	| cb |
	cb := ToCheckbox new.
	cb checked: true.
	space root addChild: cb.
	self assert: cb checked.
	cb disable.
	self assert: cb checked.
	cb addEventHandler: (BlEventHandler
			 on: ToAddedToSpaceEvent 
			 do: [ space close ])
]

{ #category : #tests }
ToCheckboxTest >> testStartUnchecked [

	| cb |
	cb := ToCheckbox new.
	cb checked: false.
	space root addChild: cb.
	self assert: cb checked not.
	cb addEventHandler: (BlEventHandler
			 on: ToAddedToSpaceEvent 
			 do: [ space close ])
]
