Class {
	#name : 'ToCheckboxTest',
	#superclass : 'ToTestCaseWithSpace',
	#category : 'Toplo-Widget-Button-Tests-Checkable',
	#package : 'Toplo-Widget-Button-Tests',
	#tag : 'Checkable'
}

{ #category : 'tests' }
ToCheckboxTest >> testCheckUncheckStates [

	| cb |
	cb := ToCheckbox new.
	self assert: cb checked not.
	cb checked: true.
	self assert: cb checked
]

{ #category : 'tests' }
ToCheckboxTest >> testChecked [

	| cb  |
	cb := ToCheckbox new.
	cb checked: true.
	self assert: cb checked.
	cb disable.
	self assert: cb checked.
	

]

{ #category : 'tests' }
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

{ #category : 'tests' }
ToCheckboxTest >> testIndeterminateState [

	| cb |
	cb := ToCheckbox new.
	self should: [ cb checked: nil] raise: Error.
	self assert: cb isIndeterminate not.
	self assert: cb isUnchecked 
]

{ #category : 'tests' }
ToCheckboxTest >> testStartChecked [

	| cb space |
	cb := ToCheckbox new.
	cb checked: true.
	space := cb openInSpace.
	self assert: cb checked.
	cb addEventHandler: (BlEventHandler
			 on: BlElementAddedToSceneGraphEvent
			 do: [ space close ])
]

{ #category : 'tests' }
ToCheckboxTest >> testStartCheckedThenDisabled [

	| cb space |
	cb := ToCheckbox new.
	cb checked: true.
	space := cb openInSpace.
	self assert: cb checked.
	cb disable.
	self assert: cb checked.
	cb addEventHandler: (BlEventHandler
			 on: BlElementAddedToSceneGraphEvent
			 do: [ space close ])
]

{ #category : 'tests' }
ToCheckboxTest >> testStartUnchecked [

	| cb space |
	cb := ToCheckbox new.
	cb checked: false.
	space := cb openInSpace.
	self assert: cb checked not.
	cb addEventHandler: (BlEventHandler
			 on: BlElementAddedToSceneGraphEvent
			 do: [ space close ])
]
