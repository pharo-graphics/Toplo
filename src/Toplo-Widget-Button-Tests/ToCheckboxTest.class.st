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
ToCheckboxTest >> testIndeterminateBar [

	| cb  |
	cb := ToCheckbox new.
	self assert: cb indeterminateBar isNil.
	space root addChild: cb.
	space applyAllSkinInstallers.
	self assert: cb indeterminateBar notNil
	
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
			 on: BlElementAddedToSceneGraphEvent
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
			 on: BlElementAddedToSceneGraphEvent
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
			 on: BlElementAddedToSceneGraphEvent
			 do: [ space close ])
]
