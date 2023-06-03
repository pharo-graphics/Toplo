Class {
	#name : #ToCheckboxTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Widget-Button'
}

{ #category : #tests }
ToCheckboxTest >> testCheckUncheckStates [

	| cb s |
	cb := ToCheckbox new.
	s := cb stateNamed: #checked.
	self assert: s notNil.
	self assert: s name equals: #checked.
	s := cb stateNamed: #unchecked.
	self assert: s notNil.
	self assert: s name equals: #unchecked
]

{ #category : #tests }
ToCheckboxTest >> testIndeterminateState [

	| cb s |
	cb := ToCheckbox new.
	self should: [ s := cb stateNamed: #indeterminate ] raise: Error.
	cb withIndeterminate.
	s := cb stateNamed: #indeterminate.
	self assert: s notNil.
	self assert: s name equals: #indeterminate
]

{ #category : #tests }
ToCheckboxTest >> testStartChecked [

	| cb space |
	cb := ToCheckbox new.
	cb startChecked.
	space := cb openInSpace.
	self assert: cb isChecked.
	cb when: BlElementAddedToSceneGraphEvent do: [ space close ].

]

{ #category : #tests }
ToCheckboxTest >> testStartIndeterminate [

	| cb space |
	cb := ToCheckbox new.
	self should: [ cb startIndeterminate ] raise: Error.
	cb withIndeterminate.
	cb startIndeterminate.
	space := cb openInSpace.
	self assert: cb isIndeterminate.
	cb when: BlElementAddedToSceneGraphEvent do: [ space close ]
]

{ #category : #tests }
ToCheckboxTest >> testStartUnchecked [

	| cb space |
	cb := ToCheckbox new.
	cb startUnchecked.
	space := cb openInSpace.
	self assert: cb isUnchecked.
	cb when: BlElementAddedToSceneGraphEvent do: [ space close ].

]
