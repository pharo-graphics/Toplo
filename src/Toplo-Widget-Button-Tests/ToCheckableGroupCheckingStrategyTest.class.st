"
A ToCheckableGroupCheckingStrategyTest is a test class for testing the behavior of ToCheckableGroupCheckingStrategy
"
Class {
	#name : #ToCheckableGroupCheckingStrategyTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Button-Tests-Checkable'
}

{ #category : #tests }
ToCheckableGroupCheckingStrategyTest >> testNoneStrategy [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group register: chb ].
	group checkingStrategy: ToCheckableGroupNoneStrategy new.
	self assert:
		(group checkingStrategy isKindOf: ToCheckableGroupNoneStrategy).
	group registeredCheckables first check.
	self assert: group registeredCheckables first checked.
	self assert:
		((group registeredCheckables copyFrom: 2 to: 4) allSatisfy: [ :btn |
			 btn checked not ]).
	group registeredCheckables first check.
	self assert:
		((group registeredCheckables copyFrom: 2 to: 4) allSatisfy: [ :btn |
			 btn checked not ]).
	group registeredCheckables first uncheck.
	self assert: group registeredCheckables first checked not.
	self assert:
		(group registeredCheckables allSatisfy: [ :btn | btn checked not ]).
	group registeredCheckables first check.
	group registeredCheckables second check.
	self assert: group registeredCheckables second checked.
	self assert: group registeredCheckables first checked.
	self assert:
		((group registeredCheckables copyFrom: 3 to: 4) allSatisfy: [ :btn |
			 btn checked not ])
]

{ #category : #tests }
ToCheckableGroupCheckingStrategyTest >> testStrictStrategy [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group register: chb ].
	self assert:
		(group checkingStrategy isKindOf: ToCheckableGroupStrictStrategy).
	group registeredCheckables first check.
	self assert: group registeredCheckables first checked.
	self assert:
		((group registeredCheckables copyFrom: 2 to: 4) allSatisfy: [ :btn |
			 btn checked not ]).
	group registeredCheckables first check.
	self assert: group registeredCheckables first checked.
	self assert:
		((group registeredCheckables copyFrom: 2 to: 4) allSatisfy: [ :btn |
			 btn checked not ]).
	group registeredCheckables first uncheck.
	self assert: group registeredCheckables first checked.
	self assert:
		((group registeredCheckables copyFrom: 2 to: 4) allSatisfy: [ :btn |
			 btn checked not ]).
	group registeredCheckables second check.
	self assert: group registeredCheckables second checked.
	self assert: group registeredCheckables first checked not.
	self assert:
		((group registeredCheckables copyFrom: 3 to: 4) allSatisfy: [ :btn |
			 btn checked not ])
]

{ #category : #tests }
ToCheckableGroupCheckingStrategyTest >> testWithUncheckStrategy [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group register: chb ].
	group checkingStrategy: ToCheckableGroupWithUncheckStrategy new.
	self assert:
		(group checkingStrategy isKindOf:
			 ToCheckableGroupWithUncheckStrategy).
	group registeredCheckables first check.
	self assert: group registeredCheckables first checked.
	self assert:
		((group registeredCheckables copyFrom: 2 to: 4) allSatisfy: [ :btn |
			 btn checked not ]).
	group registeredCheckables first check.
	self assert: group registeredCheckables first checked.
	self assert:
		((group registeredCheckables copyFrom: 2 to: 4) allSatisfy: [ :btn |
			 btn checked not ]).
	group registeredCheckables first uncheck.
	self assert:
		(group registeredCheckables allSatisfy: [ :btn | btn checked not ]).
	group registeredCheckables second check.
	self assert: group registeredCheckables second checked.
	self assert: group registeredCheckables first checked not.
	self assert:
		((group registeredCheckables copyFrom: 3 to: 4) allSatisfy: [ :btn |
			 btn checked not ]).
	group registeredCheckables third check.
	group registeredCheckables fourth check.
	self assert: group registeredCheckables first checked not.
	self assert: group registeredCheckables second checked not.
	self assert: group registeredCheckables third checked not.
	self assert: group registeredCheckables fourth checked
]
