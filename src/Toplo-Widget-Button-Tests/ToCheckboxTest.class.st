Class {
	#name : #ToCheckboxTest,
	#superclass : #TestCase,
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
ToCheckboxTest >> testIndeterminateState [

	| cb |
	cb := ToCheckbox new.
	self should: [ cb checked: nil] raise: Error.
	self assert: cb isIndeterminate not.
	self assert: cb isUnchecked 
]

{ #category : #tests }
ToCheckboxTest >> testStartChecked [

	| cb space |
	cb := ToCheckbox new.
	cb checked: true.
	space := cb openInSpace.
	self assert: cb checked.
	cb when: BlElementAddedToSceneGraphEvent do: [ space close ].

]

{ #category : #tests }
ToCheckboxTest >> testStartUnchecked [

	| cb space |
	cb := ToCheckbox new.
	cb checked: false.
	space := cb openInSpace.
	self assert: cb checked not.
	cb when: BlElementAddedToSceneGraphEvent do: [ space close ].

]