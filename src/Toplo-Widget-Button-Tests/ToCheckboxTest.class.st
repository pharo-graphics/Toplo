Class {
	#name : #ToCheckboxTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Widget-Button-Tests-Checkable'
}

{ #category : #tests }
ToCheckboxTest >> testCheckUncheckStates [

	| cb |
	cb := ToCheckbox new.
	space deferAndSettle: [ space root addChild: cb ].
	self deny: cb checked.

	space deferAndSettle: [ cb checked: true ].
	self assert: cb checked
]

{ #category : #tests }
ToCheckboxTest >> testCheckedWhenDisabled [

	| checked cb |
	cb := ToCheckbox new.
	checked := cb isChecked.
	cb checked: checked not.
	self deny: cb isChecked equals: checked.

	cb disable.
	checked := cb isChecked.
	cb checked: checked not.
	self assert: cb isChecked equals: checked
]

{ #category : #tests }
ToCheckboxTest >> testIcon [

	| cb |
	cb := ToCheckbox new.
	self assert: cb icon isNil.

	space deferAndSettle: [ space root addChild: cb ].
	self assert: cb icon notNil "Skin sets the icon"
]

{ #category : #tests }
ToCheckboxTest >> testIndeterminateState [

	| cb |
	cb := ToCheckbox new.
	space deferAndSettle: [ space root addChild: cb ].
	self should: [ cb checked: nil ] raise: Error.
	self assert: cb isIndeterminate not.
	self assert: cb isUnchecked 
]

{ #category : #tests }
ToCheckboxTest >> testLabel [

	| cb |
	cb := ToCheckbox new.
	self assert: cb label isNil.

	space deferAndSettle: [
		space root addChild: cb.
		cb label: (ToLabel text: 'Checkbox') ].

	self assert: cb label text asString equals: 'Checkbox'
]

{ #category : #tests }
ToCheckboxTest >> testStartChecked [

	| cb |
	cb := ToCheckbox new.
	self deny: cb checked.

	space deferAndSettle: [
		space root addChild: cb.
		cb checked: true ].
	self assert: cb checked.

	space deferAndSettle: [ cb disable ].
	self assert: cb checked
]

{ #category : #tests }
ToCheckboxTest >> testSwitchToNextCheckStateOnClick [

	| cb |
	cb := ToCheckbox new.
	space deferAndSettle: [ space root addChild: cb ].
	self deny: cb checked.

	cb eventSimulator click.
	self assert: cb checked.

	space deferAndSettle: [
		cb switchToNextCheckStateOnClick: false ].
	cb eventSimulator click.
	self assert: cb checked
]

{ #category : #tests }
ToCheckboxTest >> testSwitchToNextCheckStateOnDoubleClick [

	| cb |
	cb := ToCheckbox new.
	space deferAndSettle: [ space root addChild: cb ].
	self deny: cb checked.

	cb eventSimulator click.
	self assert: cb checked.

	cb eventSimulator click.
	self deny: cb checked
]
