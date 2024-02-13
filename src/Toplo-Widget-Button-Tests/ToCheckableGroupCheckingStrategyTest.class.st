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
		group add: chb ].
	group checkingStrategy: ToCheckableGroupNoneStrategy new.
	self assert: (group checkingStrategy isKindOf: ToCheckableGroupNoneStrategy).
	group buttons first check.
	self assert: group buttons first checked.
	self assert: ((group buttons copyFrom: 2 to: 4) allSatisfy: [ :btn | btn checked not ]).
	group buttons first check.
	self assert: ((group buttons copyFrom: 2 to: 4) allSatisfy: [ :btn | btn checked not ]).
	group buttons first uncheck.
	self assert: group buttons first checked not.
	self assert: (group buttons allSatisfy: [ :btn | btn checked not ]).
	group buttons first check.
	group buttons second check.
	self assert: group buttons second checked.
	self assert: group buttons first checked.
	self assert: ((group buttons copyFrom: 3 to: 4) allSatisfy: [ :btn | btn checked not ])
]

{ #category : #tests }
ToCheckableGroupCheckingStrategyTest >> testStrictStrategy [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group add: chb ].
	self assert: (group checkingStrategy isKindOf: ToCheckableGroupStrictStrategy).
	group buttons first check.
	self assert: group buttons first checked.
	self assert: ((group buttons copyFrom: 2 to: 4) allSatisfy: [ :btn | btn checked not ]).
	group buttons first check.
	self assert: group buttons first checked.
	self assert: ((group buttons copyFrom: 2 to: 4) allSatisfy: [ :btn | btn checked not ]).
	group buttons first uncheck.
	self assert: group buttons first checked.
	self assert: ((group buttons copyFrom: 2 to: 4) allSatisfy: [ :btn | btn checked not ]).
	group buttons second check.
	self assert: group buttons second checked.
	self assert: group buttons first checked not.
	self assert: ((group buttons copyFrom: 3 to: 4) allSatisfy: [ :btn | btn checked not ])
]

{ #category : #tests }
ToCheckableGroupCheckingStrategyTest >> testWithUncheckStrategy [

	| group |
	group := ToCheckableGroup new.
	1 to: 4 do: [ :idx |
		| chb |
		chb := ToCheckbox new.
		group add: chb ].
	group checkingStrategy: ToCheckableGroupWithUncheckStrategy new.
	self assert: (group checkingStrategy isKindOf: ToCheckableGroupWithUncheckStrategy).
	group buttons first check.
	self assert: group buttons first checked.
	self assert: ((group buttons copyFrom: 2 to: 4) allSatisfy: [ :btn | btn checked not ]).
	group buttons first check.
	self assert: group buttons first checked.
	self assert: ((group buttons copyFrom: 2 to: 4) allSatisfy: [ :btn | btn checked not ]).
	group buttons first uncheck.
	self assert: (group buttons allSatisfy: [ :btn | btn checked not ]).
	group buttons second check.
	self assert: group buttons second checked.
	self assert: group buttons first checked not.
	self assert: ((group buttons copyFrom: 3 to: 4) allSatisfy: [ :btn | btn checked not ]).
	group buttons third check.
	group buttons fourth check.
	self assert: group buttons first checked not.
	self assert: group buttons second checked not.
	self assert: group buttons third checked not.
	self assert: group buttons fourth checked
]
