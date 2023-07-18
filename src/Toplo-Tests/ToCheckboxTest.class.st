Class {
	#name : #ToCheckboxTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Widget-Button'
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
	cb checked: nil.
	self assert: cb isIndeterminate
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
